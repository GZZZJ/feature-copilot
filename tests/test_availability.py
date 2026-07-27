def test_conditional_and_missing_context(service):
    conditional = service.availability("fixture_payment_count_30d", "fixture_credit", "fixture_customer", observation_timing="pre_decision")
    assert conditional["conclusion"] == "conditional" and conditional["evidence"]
    incomplete = service.availability("fixture_income_avg_30d", scene="fixture_credit")
    assert incomplete["conclusion"] == "conditional" and "population" in incomplete["information_insufficient"]


def test_unknown_when_no_matching_evidence(service):
    result = service.availability("fixture_income_avg_30d", "fixture_marketing", "fixture_customer", observation_timing="pre_decision")
    assert result["conclusion"] == "unknown"


def test_availability_honors_as_of_interval(service):
    result = service.availability("fixture_retired_flag", "fixture_credit", "fixture_customer", observation_timing="pre_decision", as_of="2026-01-01")
    assert result["conclusion"] == "unknown"
