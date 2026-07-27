(function () {
  "use strict";

  var pageType = document.body.dataset.page;
  var allowedPageSizes = [20, 50, 100];

  function byId(id) {
    return document.getElementById(id);
  }

  function clearNode(node) {
    while (node && node.firstChild) {
      node.removeChild(node.firstChild);
    }
  }

  function makeElement(tag, className, text) {
    var node = document.createElement(tag);
    if (className) {
      node.className = className;
    }
    if (text !== undefined && text !== null) {
      node.textContent = String(text);
    }
    return node;
  }

  function hasValue(value) {
    return value !== null && value !== undefined && String(value).trim() !== "";
  }

  function displayValue(value, fallback) {
    if (Array.isArray(value)) {
      return value.length ? value.join("、") : (fallback || "未记录");
    }
    if (hasValue(value)) {
      return String(value);
    }
    return fallback || "未记录";
  }

  function rawCopyText(value) {
    if (Array.isArray(value)) {
      return value.join(", ");
    }
    return hasValue(value) ? String(value) : "";
  }

  function formatFeatureName(value) {
    if (!hasValue(value) || String(value).trim() === "-") {
      return "未维护";
    }
    return String(value);
  }

  function formatNumber(value) {
    return new Intl.NumberFormat("zh-CN").format(value);
  }

  function statusClass(status) {
    var normalized = String(status || "").toUpperCase();
    if (normalized === "OK" || normalized === "INDEXED" || normalized === "COMPLETE" || normalized === "FULL") {
      return "status-ok";
    }
    if (normalized === "PARTIAL" || normalized === "NOT_DOWNLOADED" || normalized === "RECURSIVE" || normalized === "WARNING") {
      return "status-partial";
    }
    if (normalized === "ERROR" || normalized === "FAILED" || normalized === "NOT_FOUND") {
      return "status-error";
    }
    if (normalized === "INLINE_MATERIALIZED") {
      return "status-info";
    }
    return "status-neutral";
  }

  function makeBadge(text, extraClass) {
    var value = displayValue(text, "UNKNOWN");
    return makeElement("span", "status-badge " + (extraClass || statusClass(value)), value);
  }

  function errorMessage(error, fallback) {
    if (error && error.payload) {
      return error.payload.message || error.payload.error || error.payload.note || fallback;
    }
    return (error && error.message) || fallback;
  }

  async function fetchJson(url, signal) {
    var response = await fetch(url, {
      headers: { "Accept": "application/json" },
      signal: signal,
      credentials: "same-origin"
    });
    var payload = null;
    try {
      payload = await response.json();
    } catch (parseError) {
      var malformed = new Error("服务返回了无法识别的响应。");
      malformed.status = response.status;
      throw malformed;
    }
    if (!response.ok) {
      var requestError = new Error(payload.message || payload.error || ("请求失败（HTTP " + response.status + "）"));
      requestError.status = response.status;
      requestError.payload = payload;
      throw requestError;
    }
    return payload;
  }

  /* ---------- Copy & toast ---------- */

  function legacyCopy(text) {
    var proxy = document.createElement("textarea");
    proxy.className = "clipboard-proxy";
    proxy.value = text;
    proxy.setAttribute("readonly", "");
    document.body.appendChild(proxy);
    proxy.select();
    var ok = false;
    try {
      ok = document.execCommand("copy");
    } catch (error) {
      ok = false;
    }
    document.body.removeChild(proxy);
    return ok;
  }

  function copyText(text) {
    if (navigator.clipboard && typeof navigator.clipboard.writeText === "function") {
      return navigator.clipboard.writeText(text).then(function () {
        return true;
      }, function () {
        return legacyCopy(text);
      });
    }
    return Promise.resolve(legacyCopy(text));
  }

  var toastRegion = null;

  function showToast(message) {
    if (!toastRegion) {
      toastRegion = makeElement("div", "toast-region");
      toastRegion.setAttribute("aria-live", "polite");
      document.body.appendChild(toastRegion);
    }
    var toast = makeElement("div", "toast");
    toast.appendChild(makeElement("span", "toast-dot"));
    toast.appendChild(makeElement("span", "", message));
    toastRegion.appendChild(toast);
    requestAnimationFrame(function () {
      toast.classList.add("toast-visible");
    });
    setTimeout(function () {
      toast.classList.remove("toast-visible");
      setTimeout(function () {
        if (toast.parentNode) {
          toast.parentNode.removeChild(toast);
        }
      }, 220);
    }, 1800);
  }

  function makeCopyIcon() {
    var NS = "http://www.w3.org/2000/svg";
    var svg = document.createElementNS(NS, "svg");
    svg.setAttribute("viewBox", "0 0 24 24");
    svg.setAttribute("aria-hidden", "true");
    var rect = document.createElementNS(NS, "rect");
    rect.setAttribute("x", "9");
    rect.setAttribute("y", "9");
    rect.setAttribute("width", "12");
    rect.setAttribute("height", "12");
    rect.setAttribute("rx", "2");
    var path = document.createElementNS(NS, "path");
    path.setAttribute("d", "M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1");
    svg.appendChild(rect);
    svg.appendChild(path);
    return svg;
  }

  function attachCopyBehavior(button, getText, label) {
    button.setAttribute("aria-label", label || "复制");
    button.title = label || "复制";
    button.addEventListener("click", function (event) {
      event.preventDefault();
      event.stopPropagation();
      var text = typeof getText === "function" ? getText() : String(getText || "");
      copyText(text).then(function (ok) {
        showToast(ok ? "已复制到剪贴板" : "复制失败，请手动选择复制");
        if (ok) {
          button.classList.add("copied");
          setTimeout(function () {
            button.classList.remove("copied");
          }, 1200);
        }
      });
    });
  }

  function makeCopyButton(getText, label) {
    var button = makeElement("button", "copy-btn");
    button.type = "button";
    button.appendChild(makeCopyIcon());
    attachCopyBehavior(button, getText, label);
    return button;
  }

  function fillTemplateCopyButton(id, getText, label) {
    var button = byId(id);
    if (!button) {
      return;
    }
    button.appendChild(makeCopyIcon());
    attachCopyBehavior(button, getText, label);
  }

  /* ---------- SQL highlight (local tokenizer, no innerHTML) ---------- */

  var SQL_KEYWORD_SET = {};
  ("select from where join left right inner outer full cross on and or not in is null as case when then else end " +
    "group by order having limit union all distinct with insert overwrite table partition between like exists asc desc " +
    "into values set update delete create drop lateral view distribute sort cluster").split(" ").forEach(function (word) {
    SQL_KEYWORD_SET[word] = true;
  });

  function highlightSqlInto(pre, code) {
    clearNode(pre);
    var text = String(code);
    var pattern = /(--[^\n]*)|(\/\*[\s\S]*?\*\/)|('(?:[^']|'')*')|(\b\d+(?:\.\d+)?\b)|([A-Za-z_][A-Za-z0-9_$]*)/g;
    var lastIndex = 0;
    var match;
    while ((match = pattern.exec(text)) !== null) {
      if (match.index > lastIndex) {
        pre.appendChild(document.createTextNode(text.slice(lastIndex, match.index)));
      }
      var tokenClass = null;
      if (match[1] || match[2]) {
        tokenClass = "tok-comment";
      } else if (match[3]) {
        tokenClass = "tok-string";
      } else if (match[4]) {
        tokenClass = "tok-number";
      } else if (match[5]) {
        if (SQL_KEYWORD_SET[match[5].toLowerCase()]) {
          tokenClass = "tok-keyword";
        } else if (text.charAt(pattern.lastIndex) === "(") {
          tokenClass = "tok-func";
        }
      }
      if (tokenClass) {
        pre.appendChild(makeElement("span", tokenClass, match[0]));
      } else {
        pre.appendChild(document.createTextNode(match[0]));
      }
      lastIndex = pattern.lastIndex;
    }
    if (lastIndex < text.length) {
      pre.appendChild(document.createTextNode(text.slice(lastIndex)));
    }
  }

  /* ---------- Index health ---------- */

  function isStaleIndex(indexInfo) {
    if (!indexInfo || typeof indexInfo !== "object") {
      return false;
    }
    var state = String(indexInfo.status || indexInfo.state || indexInfo.mode || "").toUpperCase();
    return indexInfo.stale === true || indexInfo.fresh === false || indexInfo.using_stale_index === true ||
      state === "STALE" || state === "DEGRADED" || state === "WARNING";
  }

  function showStaleIndex(indexInfo) {
    if (!indexInfo || typeof indexInfo !== "object") {
      return;
    }
    if (!isStaleIndex(indexInfo)) {
      return;
    }
    var banner = byId("stale-banner");
    var text = byId("stale-banner-text");
    if (text) {
      text.textContent = indexInfo.warning || indexInfo.message || "索引构建异常，当前展示最近一次可用数据。";
    }
    if (banner) {
      banner.hidden = false;
    }
  }

  function updateIndexTile(indexInfo) {
    var tile = byId("index-status-tile");
    if (!tile) {
      return;
    }
    if (!indexInfo || typeof indexInfo !== "object") {
      tile.textContent = "未知";
      return;
    }
    tile.textContent = isStaleIndex(indexInfo) ? "降级" : "正常";
  }

  async function checkHealth() {
    try {
      var health = await fetchJson("/api/v1/health");
      var info = health.index || health;
      showStaleIndex(info);
      updateIndexTile(info);
    } catch (error) {
      // The primary request owns the blocking error state. Health is advisory only.
      updateIndexTile(null);
    }
  }

  /* ---------- Definition lists ---------- */

  function appendDefinitionList(container, entries) {
    clearNode(container);
    entries.forEach(function (entry) {
      var wrapper = makeElement("div", "metadata-item");
      var body = wrapper;
      if (entry.copyable) {
        wrapper.classList.add("evidence-item");
        body = makeElement("div", "");
        wrapper.appendChild(body);
        wrapper.appendChild(makeCopyButton(function () {
          return rawCopyText(entry.value);
        }, "复制 " + String(entry.label).toLowerCase()));
      }
      var term = makeElement("dt", "", entry.label);
      var value = makeElement("dd", entry.mono ? "mono-value" : "", displayValue(entry.value, entry.fallback));
      if (!hasValue(entry.value) || (Array.isArray(entry.value) && !entry.value.length)) {
        value.classList.add("missing-value");
      }
      body.appendChild(term);
      body.appendChild(value);
      container.appendChild(wrapper);
    });
  }

  function initListPage() {
    var form = byId("search-form");
    var keyInput = byId("feature-key");
    var nameInput = byId("feature-name");
    var categorySelect = byId("feature-category");
    var subcategorySelect = byId("feature-subcategory");
    var featureGroupSelect = byId("feature-group");
    var pageSizeSelect = byId("page-size");
    var requestSequence = 0;
    var activeController = null;
    var taxonomy = [];
    var taxonomyReady = false;
    var taxonomyLoading = false;
    var state = readListState();

    function positiveInteger(value, fallback) {
      var parsed = Number(value);
      return Number.isInteger(parsed) && parsed > 0 ? parsed : fallback;
    }

    function readListState() {
      var params = new URLSearchParams(window.location.search);
      var size = positiveInteger(params.get("page_size"), 50);
      if (allowedPageSizes.indexOf(size) === -1) {
        size = 50;
      }
      return {
        featureKey: params.get("feature_key") || "",
        featureName: params.get("feature_name") || "",
        featureCategory: params.get("feature_category") || "",
        businessSubcategory: params.get("business_subcategory") || "",
        featureGroup: params.get("feature_group") || params.get("feature_subcategory") || "",
        page: positiveInteger(params.get("page"), 1),
        pageSize: size
      };
    }

    function appendOption(select, value, label) {
      var option = document.createElement("option");
      option.value = value;
      option.textContent = label;
      select.appendChild(option);
    }

    function labelWithCount(item) {
      var label = displayValue(item.label, item.value);
      return Number.isFinite(Number(item.count)) ? label + "（" + formatNumber(Number(item.count)) + "）" : label;
    }

    function selectedCategory() {
      return taxonomy.filter(function (item) {
        return String(item.value) === state.featureCategory;
      })[0] || null;
    }

    function renderCategoryOptions() {
      clearNode(categorySelect);
      appendOption(categorySelect, "", "全部大类");
      taxonomy.forEach(function (item) {
        appendOption(categorySelect, String(item.value), labelWithCount(item));
      });
      categorySelect.value = state.featureCategory;
      if (categorySelect.value !== state.featureCategory) {
        state.featureCategory = "";
        state.businessSubcategory = "";
        state.featureGroup = "";
      }
    }

    function renderSubcategoryOptions() {
      var category = selectedCategory();
      clearNode(subcategorySelect);
      if (!category) {
        appendOption(subcategorySelect, "", "请先选择特征大类");
        subcategorySelect.disabled = true;
        return;
      }
      appendOption(subcategorySelect, "", "全部小类");
      (Array.isArray(category.subcategories) ? category.subcategories : []).forEach(function (item) {
        appendOption(subcategorySelect, String(item.value), labelWithCount(item));
      });
      subcategorySelect.disabled = false;
      subcategorySelect.value = state.businessSubcategory;
      if (subcategorySelect.value !== state.businessSubcategory) {
        state.businessSubcategory = "";
        subcategorySelect.value = "";
      }
    }

    function availableGroups() {
      var category = selectedCategory();
      if (!category) {
        return [];
      }
      var subcategories = Array.isArray(category.subcategories) ? category.subcategories : [];
      if (state.businessSubcategory) {
        var selected = subcategories.filter(function (item) {
          return String(item.value) === state.businessSubcategory;
        })[0];
        return selected && Array.isArray(selected.groups) ? selected.groups : [];
      }
      var byValue = {};
      subcategories.forEach(function (subcategory) {
        (Array.isArray(subcategory.groups) ? subcategory.groups : []).forEach(function (group) {
          var value = String(group.value);
          if (!byValue[value]) {
            byValue[value] = { value: value, label: group.label, count: 0 };
          }
          byValue[value].count += Number(group.count) || 0;
        });
      });
      return Object.keys(byValue).sort().map(function (value) { return byValue[value]; });
    }

    function renderFeatureGroupOptions() {
      var category = selectedCategory();
      clearNode(featureGroupSelect);
      if (!category) {
        appendOption(featureGroupSelect, "", "请先选择特征大类");
        featureGroupSelect.disabled = true;
        return;
      }
      appendOption(featureGroupSelect, "", "全部加工特征组");
      availableGroups().forEach(function (item) {
        appendOption(featureGroupSelect, String(item.value), labelWithCount(item));
      });
      featureGroupSelect.disabled = false;
      featureGroupSelect.value = state.featureGroup;
      if (featureGroupSelect.value !== state.featureGroup) {
        state.featureGroup = "";
        featureGroupSelect.value = "";
      }
    }

    function renderUnavailableTaxonomy(message) {
      clearNode(categorySelect);
      appendOption(categorySelect, "", "全部大类");
      if (state.featureCategory) {
        appendOption(categorySelect, state.featureCategory, state.featureCategory + "（当前条件）");
        categorySelect.value = state.featureCategory;
      }
      categorySelect.disabled = true;

      clearNode(subcategorySelect);
      if (state.businessSubcategory) {
        appendOption(subcategorySelect, state.businessSubcategory, state.businessSubcategory + "（当前条件）");
        subcategorySelect.value = state.businessSubcategory;
      } else {
        appendOption(subcategorySelect, "", "请先选择特征大类");
      }
      subcategorySelect.disabled = true;
      clearNode(featureGroupSelect);
      if (state.featureGroup) {
        appendOption(featureGroupSelect, state.featureGroup, state.featureGroup + "（当前条件）");
        featureGroupSelect.value = state.featureGroup;
      } else {
        appendOption(featureGroupSelect, "", "请先选择特征大类");
      }
      featureGroupSelect.disabled = true;
      byId("category-help").textContent = message;
    }

    async function loadTaxonomy() {
      taxonomyLoading = true;
      taxonomyReady = false;
      renderUnavailableTaxonomy("分类加载中…");
      try {
        var payload = await fetchJson("/api/v1/feature-taxonomy");
        if (payload.status !== "OK" || !Array.isArray(payload.categories)) {
          throw new Error("分类接口字段不完整。");
        }
        taxonomy = payload.categories.filter(function (item) {
          return item && hasValue(item.value);
        });
        taxonomyReady = true;
        categorySelect.disabled = false;
        byId("category-help").textContent = "单选";
        renderCategoryOptions();
        renderSubcategoryOptions();
        renderFeatureGroupOptions();
      } catch (error) {
        taxonomy = [];
        renderUnavailableTaxonomy("分类暂时不可用，提交查询可重试");
      } finally {
        taxonomyLoading = false;
      }
    }

    function syncControls() {
      keyInput.value = state.featureKey;
      nameInput.value = state.featureName;
      pageSizeSelect.value = String(state.pageSize);
      if (taxonomyReady) {
        renderCategoryOptions();
        renderSubcategoryOptions();
        renderFeatureGroupOptions();
      } else if (!taxonomyLoading) {
        renderUnavailableTaxonomy("分类暂时不可用，提交查询可重试");
      }
    }

    function buildListUrl() {
      var params = new URLSearchParams();
      if (state.featureKey) {
        params.set("feature_key", state.featureKey);
      }
      if (state.featureName) {
        params.set("feature_name", state.featureName);
      }
      if (state.featureCategory) {
        params.set("feature_category", state.featureCategory);
      }
      if (state.businessSubcategory) {
        params.set("business_subcategory", state.businessSubcategory);
      }
      if (state.featureGroup) {
        params.set("feature_group", state.featureGroup);
      }
      params.set("page", String(state.page));
      params.set("page_size", String(state.pageSize));
      return "/features?" + params.toString();
    }

    function updateBrowserUrl(replace) {
      var method = replace ? "replaceState" : "pushState";
      window.history[method](null, "", buildListUrl());
    }

    function apiUrl() {
      var params = new URLSearchParams();
      if (state.featureKey) {
        params.set("feature_key", state.featureKey);
      }
      if (state.featureName) {
        params.set("feature_name", state.featureName);
      }
      if (state.featureCategory) {
        params.set("feature_category", state.featureCategory);
      }
      if (state.businessSubcategory) {
        params.set("business_subcategory", state.businessSubcategory);
      }
      if (state.featureGroup) {
        params.set("feature_group", state.featureGroup);
      }
      params.set("page", String(state.page));
      params.set("page_size", String(state.pageSize));
      return "/api/v1/features?" + params.toString();
    }

    function setListState(view) {
      byId("list-loading").hidden = view !== "loading";
      byId("list-error").hidden = view !== "error";
      byId("list-empty").hidden = view !== "empty";
      byId("table-region").hidden = view !== "table";
      byId("pagination").hidden = view !== "table";
      byId("registry-title").closest("section").setAttribute("aria-busy", view === "loading" ? "true" : "false");
    }

    function makeCell(row, className, value, missingName) {
      var cell = makeElement("td", className || "");
      var content = missingName ? formatFeatureName(value) : displayValue(value);
      if (missingName && content === "未维护") {
        var muted = makeElement("span", "cell-muted", content);
        cell.appendChild(muted);
      } else {
        cell.textContent = content;
      }
      row.appendChild(cell);
      return cell;
    }

    function renderRows(items) {
      var body = byId("feature-table-body");
      clearNode(body);
      var returnPath = window.location.pathname + window.location.search;
      items.forEach(function (item) {
        var row = document.createElement("tr");
        var featureCode = displayValue(item.feature_code, "");

        var keyCell = makeElement("td", "cell-key");
        var keyInner = makeElement("div", "key-cell-inner");
        keyInner.appendChild(makeElement("span", "cell-key-text", featureCode));
        if (featureCode) {
          keyInner.appendChild(makeCopyButton(featureCode, "复制特征 Key"));
        }
        keyCell.appendChild(keyInner);
        row.appendChild(keyCell);

        var nameCell = makeCell(row, "cell-name", item.feature_name, true);
        var governance = item.usage_governance || {};
        if (governance.is_recommended === false) {
          var governanceBadge = makeElement("span", "usage-governance-badge", displayValue(governance.usage_label, "不推荐使用"));
          governanceBadge.title = displayValue(governance.message);
          nameCell.appendChild(governanceBadge);
        }
        makeCell(row, "", item.feature_category);
        makeCell(row, "", item.business_subcategory_name || item.business_subcategory_code);
        makeCell(row, "", item.group_name || item.group_code);
        makeCell(row, "cell-table", item.table_name);

        var action = makeElement("td", "action-column");
        if (featureCode) {
          var href = "/features/" + encodeURIComponent(featureCode) + "?from=" + encodeURIComponent(returnPath);
          var link = makeElement("a", "detail-link", "详情");
          link.href = href;
          link.setAttribute("aria-label", "查看特征 " + featureCode + " 的详情");
          link.appendChild(makeElement("span", "link-arrow", "→"));
          link.addEventListener("click", function (event) {
            event.stopPropagation();
          });
          action.appendChild(link);

          row.dataset.href = href;
          row.tabIndex = 0;
          row.setAttribute("role", "link");
          row.setAttribute("aria-label", "查看特征 " + featureCode + " 的详情");
          row.addEventListener("click", function () {
            window.location.assign(href);
          });
          row.addEventListener("keydown", function (event) {
            if (event.key === "Enter") {
              event.preventDefault();
              window.location.assign(href);
            }
          });
        } else {
          action.appendChild(makeElement("span", "cell-muted", "不可用"));
        }
        row.appendChild(action);
        body.appendChild(row);
      });
    }

    function renderPagination(total, page, pageSize) {
      var totalPages = Math.max(1, Math.ceil(total / pageSize));
      byId("page-indicator").textContent = "第 " + page + " / " + totalPages + " 页";
      byId("previous-page").disabled = page <= 1;
      byId("next-page").disabled = page >= totalPages;
      byId("previous-page").setAttribute("aria-label", "上一页，第 " + Math.max(1, page - 1) + " 页");
      byId("next-page").setAttribute("aria-label", "下一页，第 " + Math.min(totalPages, page + 1) + " 页");
    }

    async function loadList() {
      requestSequence += 1;
      var sequence = requestSequence;
      if (activeController) {
        activeController.abort();
      }
      activeController = new AbortController();
      setListState("loading");
      byId("result-summary").textContent = "正在读取索引…";

      try {
        var payload = await fetchJson(apiUrl(), activeController.signal);
        if (sequence !== requestSequence) {
          return;
        }
        if (payload.status !== "OK") {
          throw new Error("接口状态异常：" + displayValue(payload.status));
        }
        if (!Array.isArray(payload.items) || !Number.isFinite(Number(payload.total))) {
          throw new Error("列表接口字段不完整。");
        }
        showStaleIndex(payload.index);
        var total = Number(payload.total);
        var actualPage = Number(payload.page);
        var actualPageSize = Number(payload.page_size);
        if (!Number.isInteger(actualPage) || actualPage < 1 || allowedPageSizes.indexOf(actualPageSize) === -1) {
          throw new Error("列表接口返回了无效的分页信息。");
        }
        var totalPages = Math.max(1, Math.ceil(total / actualPageSize));
        if (total > 0 && state.page > totalPages) {
          state.page = totalPages;
          updateBrowserUrl(true);
          syncControls();
          loadList();
          return;
        }
        state.page = actualPage;
        state.pageSize = actualPageSize;
        syncControls();
        byId("result-total").textContent = formatNumber(total);

        if (payload.items.length === 0) {
          byId("result-summary").textContent = "0 条匹配记录";
          setListState("empty");
          return;
        }

        renderRows(payload.items);
        renderPagination(total, actualPage, actualPageSize);
        var start = (actualPage - 1) * actualPageSize + 1;
        var end = Math.min(total, start + payload.items.length - 1);
        byId("result-summary").textContent = "显示 " + formatNumber(start) + "–" + formatNumber(end) + " / 共 " + formatNumber(total) + " 条";
        setListState("table");
      } catch (error) {
        if (error && error.name === "AbortError") {
          return;
        }
        byId("result-total").textContent = "—";
        byId("result-summary").textContent = "查询中断";
        byId("list-error-message").textContent = errorMessage(error, "暂时无法访问特征索引。");
        setListState("error");
      }
    }

    form.addEventListener("submit", function (event) {
      event.preventDefault();
      state.featureKey = keyInput.value.trim();
      state.featureName = nameInput.value.trim();
      if (taxonomyReady) {
        state.featureCategory = categorySelect.value;
        state.businessSubcategory = subcategorySelect.disabled ? "" : subcategorySelect.value;
        state.featureGroup = featureGroupSelect.disabled ? "" : featureGroupSelect.value;
      }
      state.page = 1;
      updateBrowserUrl(false);
      loadList();
      if (!taxonomyReady && !taxonomyLoading) {
        loadTaxonomy();
      }
    });

    byId("reset-button").addEventListener("click", function () {
      state = { featureKey: "", featureName: "", featureCategory: "", businessSubcategory: "", featureGroup: "", page: 1, pageSize: 50 };
      syncControls();
      updateBrowserUrl(false);
      loadList();
      keyInput.focus();
    });

    pageSizeSelect.addEventListener("change", function () {
      var size = Number(pageSizeSelect.value);
      state.pageSize = allowedPageSizes.indexOf(size) === -1 ? 50 : size;
      state.page = 1;
      updateBrowserUrl(false);
      loadList();
    });

    categorySelect.addEventListener("change", function () {
      state.featureCategory = categorySelect.value;
      state.businessSubcategory = "";
      state.featureGroup = "";
      renderSubcategoryOptions();
      renderFeatureGroupOptions();
    });

    subcategorySelect.addEventListener("change", function () {
      state.businessSubcategory = subcategorySelect.value;
      state.featureGroup = "";
      renderFeatureGroupOptions();
    });

    byId("previous-page").addEventListener("click", function () {
      if (state.page > 1) {
        state.page -= 1;
        updateBrowserUrl(false);
        loadList();
        byId("registry-title").focus({ preventScroll: true });
      }
    });

    byId("next-page").addEventListener("click", function () {
      state.page += 1;
      updateBrowserUrl(false);
      loadList();
      byId("registry-title").focus({ preventScroll: true });
    });

    byId("retry-button").addEventListener("click", function () {
      loadTaxonomy().then(loadList);
    });

    window.addEventListener("popstate", function () {
      state = readListState();
      syncControls();
      loadList();
    });

    syncControls();
    loadTaxonomy().then(loadList);
    checkHealth();
  }

  function initDetailPage() {
    var activeController = null;
    var encodedKey = window.location.pathname.slice("/features/".length);
    var featureKey = "";
    try {
      featureKey = decodeURIComponent(encodedKey);
    } catch (error) {
      featureKey = "";
    }

    var loadedKey = "";
    var loadedExpression = "";
    var loadedDirectSql = "";

    fillTemplateCopyButton("copy-key-btn", function () {
      return loadedKey || featureKey;
    }, "复制特征 Key");
    fillTemplateCopyButton("copy-expression-btn", function () {
      return loadedExpression;
    }, "复制表达式");
    fillTemplateCopyButton("copy-sql-btn", function () {
      return loadedDirectSql;
    }, "复制 SQL");

    function safeReturnUrl() {
      var candidate = new URLSearchParams(window.location.search).get("from");
      if (!candidate) {
        return "/features";
      }
      try {
        var url = new URL(candidate, window.location.origin);
        if (url.origin === window.location.origin && url.pathname === "/features") {
          return url.pathname + url.search;
        }
      } catch (error) {
        return "/features";
      }
      return "/features";
    }

    var returnUrl = safeReturnUrl();
    byId("back-link").href = returnUrl;
    byId("hero-back-link").href = returnUrl;

    function setDetailState(view) {
      byId("detail-loading").hidden = view !== "loading";
      byId("detail-error").hidden = view !== "error";
      byId("detail-content").hidden = view !== "content";
      byId("main-content").setAttribute("aria-busy", view === "loading" ? "true" : "false");
    }

    function formatTodayFlag(value) {
      var normalized = String(value || "").trim().toLowerCase();
      if (["1", "true", "yes", "y", "是"].indexOf(normalized) !== -1) {
        return "是";
      }
      if (["0", "false", "no", "n", "否"].indexOf(normalized) !== -1) {
        return "否";
      }
      return displayValue(value);
    }

    function addBadges(logic) {
      var container = byId("coverage-badges");
      clearNode(container);
      container.appendChild(makeBadge("LOGIC " + displayValue(logic.status, "UNKNOWN"), statusClass(logic.status)));
      var coverageStatus = logic.coverage && logic.coverage.coverage_status;
      if (hasValue(coverageStatus)) {
        container.appendChild(makeBadge("COVERAGE " + coverageStatus, statusClass(coverageStatus)));
      }
    }

    function renderDiagnostics(logic) {
      var diagnostics = Array.isArray(logic.diagnostics) ? logic.diagnostics.slice() : [];
      var missing = logic.coverage && logic.coverage.missing_dp_tables;
      if (hasValue(missing)) {
        var missingItems = String(missing).split(/[,|]/).map(function (item) { return item.trim(); }).filter(Boolean);
        missingItems.forEach(function (item) {
          var diagnostic = "logic_not_downloaded:" + item;
          if (diagnostics.indexOf(diagnostic) === -1) {
            diagnostics.push(diagnostic);
          }
        });
      }

      var panel = byId("diagnostics");
      var list = byId("diagnostic-list");
      clearNode(list);
      diagnostics.forEach(function (diagnostic) {
        var raw = String(diagnostic);
        var label = raw;
        if (raw.indexOf("logic_not_downloaded:") === 0) {
          label = "逻辑未下载：" + raw.slice("logic_not_downloaded:".length);
        } else if (raw.indexOf("cycle_detected:") === 0) {
          label = "检测到循环依赖：" + raw.slice("cycle_detected:".length);
        } else if (raw.indexOf("max_depth_reached:") === 0) {
          label = "已达到深度限制：" + raw.slice("max_depth_reached:".length);
        }
        list.appendChild(makeElement("li", "", label));
      });
      panel.hidden = diagnostics.length === 0;

      var warning = byId("logic-warning");
      var warningText = byId("logic-warning-text");
      var partial = String(logic.status || "").toUpperCase() === "PARTIAL";
      warning.hidden = !partial;
      if (partial) {
        warningText.textContent = diagnostics.length ?
          "已返回可用逻辑，同时发现 " + diagnostics.length + " 项血缘诊断；请结合下方节点状态判断覆盖范围。" :
          "已返回可用逻辑，但索引标记为 PARTIAL；部分加工信息可能尚未入库。";
      }
    }

    function appendNodeMeta(container, label, value) {
      var wrapper = makeElement("div", "node-meta");
      wrapper.appendChild(makeElement("span", "", label));
      wrapper.appendChild(makeElement("strong", "", displayValue(value)));
      container.appendChild(wrapper);
    }

    function renderUpstream(logic) {
      var layers = Array.isArray(logic.upstream_layers) ? logic.upstream_layers : [];
      var container = byId("upstream-layers");
      clearNode(container);
      container.classList.add("lineage-flow");
      byId("upstream-empty").hidden = layers.some(function (layer) {
        return Array.isArray(layer.tables) && layer.tables.length;
      });
      byId("upstream-summary").textContent = "共 " + layers.length + " 层 · SQL 为有界摘要";

      layers.forEach(function (layer, layerIndex) {
        var section = makeElement("section", "lineage-layer");
        var heading = makeElement("div", "layer-heading");
        heading.appendChild(makeElement("span", "layer-number", "LAYER " + displayValue(layer.depth, layerIndex + 1)));
        heading.appendChild(makeElement("h3", "", "第 " + displayValue(layer.depth, layerIndex + 1) + " 层上游"));
        section.appendChild(heading);

        var nodesWrap = makeElement("div", "lineage-nodes");
        var tables = Array.isArray(layer.tables) ? layer.tables : [];
        tables.forEach(function (table, tableIndex) {
          var details = makeElement("details", "lineage-node");
          details.setAttribute("data-state", String(table.state || "").toLowerCase());
          if (layerIndex === 0 && tableIndex === 0) {
            details.open = true;
          }
          var summary = makeElement("summary", "lineage-node-summary");
          var titleWrap = makeElement("div", "summary-title");
          titleWrap.appendChild(makeElement("span", "summary-caret", "▸"));
          var main = makeElement("div", "table-summary-main");
          main.appendChild(makeElement("span", "table-name", displayValue(table.table_name)));
          var parents = Array.isArray(table.parents) ? table.parents.join("、") : table.parents;
          main.appendChild(makeElement("span", "table-parent", "下游：" + displayValue(parents)));
          titleWrap.appendChild(main);
          summary.appendChild(titleWrap);
          summary.appendChild(makeBadge(displayValue(table.state, "UNKNOWN"), statusClass(table.state)));
          details.appendChild(summary);

          var content = makeElement("div", "node-content");
          var nodes = Array.isArray(table.logic_nodes) ? table.logic_nodes : [];
          if (String(table.state || "").toLowerCase() === "not_downloaded" || nodes.length === 0) {
            content.appendChild(makeElement("p", "node-warning", "该表加工逻辑尚未下载或未进入索引，血缘在此处中断。"));
          }
          nodes.forEach(function (node, nodeIndex) {
            var logicNode = makeElement("article", "logic-node");
            var nodeHeader = makeElement("div", "logic-node-header");
            appendNodeMeta(nodeHeader, "TASK", node.task_name);
            appendNodeMeta(nodeHeader, "OWNER", node.owner_name);
            appendNodeMeta(nodeHeader, "NODE ID", node.node_id);
            appendNodeMeta(nodeHeader, "SOURCE", node.source_path);
            logicNode.appendChild(nodeHeader);

            var sqlText = displayValue(node.sql);
            var head = makeElement("div", "code-panel-head");
            head.appendChild(makeElement("p", "code-label", "SQL EXCERPT / NODE " + (nodeIndex + 1)));
            head.appendChild(makeCopyButton(sqlText, "复制 SQL"));
            logicNode.appendChild(head);

            var sql = makeElement("pre", "");
            sql.tabIndex = 0;
            highlightSqlInto(sql, sqlText);
            logicNode.appendChild(sql);
            content.appendChild(logicNode);
          });
          details.appendChild(content);
          nodesWrap.appendChild(details);
        });
        section.appendChild(nodesWrap);
        container.appendChild(section);
      });
    }

    function renderEvidence(evidence, feature, directLogic) {
      var entries = [
        { label: "FEATURE SOURCE", value: evidence.feature_source || feature.source_path, mono: true, copyable: true },
        { label: "GROUP LOGIC SOURCE", value: evidence.group_logic_source || directLogic.source_path, mono: true, copyable: true }
      ];
      Object.keys(evidence).forEach(function (key) {
        if (key === "feature_source" || key === "group_logic_source" || key === "index") {
          return;
        }
        entries.push({ label: key.replace(/_/g, " ").toUpperCase(), value: evidence[key], mono: true, copyable: true });
      });
      appendDefinitionList(byId("evidence-grid"), entries);
    }

    function renderDetail(payload) {
      var feature = payload.feature || {};
      var logic = payload.logic || {};
      var direct = logic.direct_logic || {};
      var derivation = direct.derivation || {};
      var coverage = logic.coverage || {};
      var featureName = formatFeatureName(feature.feature_name);
      var key = displayValue(feature.feature_code, featureKey);
      var governance = payload.usage_governance || {};

      loadedKey = key;
      document.title = featureName + " · Feature Copilot";
      byId("detail-name").textContent = featureName;
      byId("detail-key").textContent = key;
      var statusBadge = byId("logic-status-badge");
      statusBadge.textContent = displayValue(logic.status, "UNKNOWN");
      statusBadge.className = "status-badge " + statusClass(logic.status);

      var governanceWarning = byId("usage-governance-warning");
      if (governance.is_recommended === false) {
        byId("usage-governance-title").textContent = displayValue(governance.usage_label, "不推荐使用") + " · " + displayValue(governance.reason_label, "特征使用治理");
        byId("usage-governance-message").textContent = displayValue(governance.message, "该特征不推荐使用。");
        byId("usage-governance-source").textContent = governance.source_ref ? "依据：" + governance.source_ref : "";
        governanceWarning.hidden = false;
      } else {
        governanceWarning.hidden = true;
      }

      appendDefinitionList(byId("metadata-grid"), [
        { label: "FEATURE KEY", value: feature.feature_code, mono: true },
        { label: "COLUMN NAME", value: feature.feature_column_name, mono: true },
        { label: "FEATURE NAME", value: featureName },
        { label: "CATEGORY", value: feature.feature_category },
        { label: "BUSINESS SUBCATEGORY", value: feature.business_subcategory_name },
        { label: "SUBCATEGORY CODE", value: feature.business_subcategory_code, mono: true },
        { label: "GROUP CODE", value: feature.group_code, mono: true },
        { label: "GROUP NAME", value: feature.group_name },
        { label: "SOURCE TABLE", value: feature.table_name, mono: true },
        { label: "DOMAIN", value: feature.domain_code, mono: true },
        { label: "INCLUDE TODAY", value: formatTodayFlag(feature.include_today_flag) },
        { label: "TIME RANGE", value: feature.time_range },
        { label: "USAGE STATUS", value: governance.usage_label, mono: governance.is_recommended === false },
        { label: "USAGE REASON", value: governance.reason_label },
        { label: "PACKAGES", value: feature.packages },
        { label: "EVIDENCE PATH", value: feature.source_path, mono: true }
      ]);

      addBadges(logic);
      appendDefinitionList(byId("logic-metadata"), [
        { label: "GROUP CODE", value: direct.group_code || feature.group_code, mono: true },
        { label: "LOGIC VERSION", value: direct.logic_version, mono: true },
        { label: "MODIFIED AT", value: direct.modify_time, mono: true },
        { label: "MODIFIED BY", value: direct.last_modifier },
        { label: "COVERAGE", value: coverage.coverage_status, mono: true },
        { label: "LOGIC SOURCE", value: coverage.logic_source, mono: true },
        { label: "LINE RANGE", value: hasValue(derivation.line_start) ? derivation.line_start + "–" + displayValue(derivation.line_end, derivation.line_start) : null, mono: true },
        { label: "SOURCE PATH", value: direct.source_path, mono: true }
      ]);

      var derivationBadge = byId("derivation-status");
      derivationBadge.textContent = displayValue(derivation.status, "UNKNOWN");
      derivationBadge.className = "status-badge " + statusClass(derivation.status);

      loadedExpression = displayValue(derivation.expression);
      loadedDirectSql = displayValue(direct.sql || derivation.snippet);
      highlightSqlInto(byId("derivation-expression"), loadedExpression);
      highlightSqlInto(byId("direct-sql"), loadedDirectSql);

      renderDiagnostics(logic);
      renderUpstream(logic);
      renderEvidence(payload.evidence || {}, feature, direct);
      showStaleIndex(payload.index || (payload.evidence && payload.evidence.index));
    }

    async function loadDetail() {
      if (!featureKey) {
        byId("detail-error-title").textContent = "特征 Key 无效";
        byId("detail-error-message").textContent = "当前地址中没有可识别的特征 Key。";
        byId("detail-retry-button").hidden = true;
        setDetailState("error");
        return;
      }
      if (activeController) {
        activeController.abort();
      }
      activeController = new AbortController();
      byId("detail-retry-button").hidden = false;
      setDetailState("loading");
      try {
        var payload = await fetchJson("/api/v1/features/" + encodeURIComponent(featureKey), activeController.signal);
        if (payload.status !== "OK") {
          throw new Error("接口状态异常：" + displayValue(payload.status));
        }
        if (!payload.feature || !payload.logic) {
          throw new Error("详情接口字段不完整。");
        }
        renderDetail(payload);
        setDetailState("content");
      } catch (error) {
        if (error && error.name === "AbortError") {
          return;
        }
        var notFound = error && error.status === 404;
        byId("detail-error-title").textContent = notFound ? "未找到该特征" : "详情加载失败";
        byId("detail-error-message").textContent = errorMessage(error, notFound ? "该 Key 不在受控特征索引中。" : "暂时无法访问特征索引。");
        setDetailState("error");
      }
    }

    byId("detail-retry-button").addEventListener("click", loadDetail);
    loadDetail();
    checkHealth();
  }

  if (pageType === "list") {
    initListPage();
  } else if (pageType === "detail") {
    initDetailPage();
  }
})();
