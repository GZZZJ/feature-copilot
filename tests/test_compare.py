def test_compare_is_structured_hint_not_duplicate_claim(service):
    result = service.compare(["fixture_income_avg_30d", "fixture_payment_count_30d"])
    assert result["status"] == "OK"
    assert result["differences"]["stat_method"]
    assert result["logic_similarity_hint"]["identical_selected_fields"] is False
    assert "重复" in result["logic_similarity_hint"]["note"]
    assert result["historical_performance"]
    assert "空值" in result["null_value_convention"]
    assert result["differences"]["null_handling"]["fixture_income_avg_30d@2.0.0"]["status"] == "not_recorded"
