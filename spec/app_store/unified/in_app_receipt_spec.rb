# frozen_string_literal: true

require 'spec_helper'

describe CandyCheck::AppStore::Unified::InAppReceipt do
  subject { CandyCheck::AppStore::Unified::InAppReceipt.new(attributes) }

  let(:attributes) { JSON.parse(<<-RECEIPT) }
    {
      "quantity": "1",
      "product_id": "com.app.product",
      "transaction_id": "1000000318232140",
      "original_transaction_id": "1000000359615195",
      "purchase_date": "2017-07-25 00:55:46 Etc/GMT",
      "original_purchase_date": "2017-07-25 00:15:46 Etc/GMT",
      "expires_date": "2017-12-14 16:34:33 Etc/GMT",
      "expiration_intent": "4",
      "is_in_billing_retry_period": "0",
      "is_trial_period": "false",
      "cancellation_date": "2017-07-27 00:55:46 Etc/GMT",
      "cancellation_reason": 1,
      "app_item_id": 0,
      "version_external_identifier": 3,
      "web_order_line_item_id": "1000000037216020",
      "auto_renew_status": "0",
      "price_consent_status": "1"
    }
  RECEIPT

  it 'returns quantity' do
    _(subject.quantity).must_equal 1
  end

  it 'returns product_id' do
    _(subject.product_id).must_equal 'com.app.product'
  end

  it 'returns transaction_id' do
    _(subject.transaction_id).must_equal '1000000318232140'
  end

  it 'returns original_transaction_id' do
    _(subject.original_transaction_id).must_equal '1000000359615195'
  end

  it 'returns purchase_date' do
    expected = DateTime.new(2017, 7, 25, 0, 55, 46)
    _(subject.purchase_date).must_equal expected
  end

  it 'returns original_purchase_date' do
    expected = DateTime.new(2017, 7, 25, 0, 15, 46)
    _(subject.original_purchase_date).must_equal expected
  end

  it 'returns expires_date' do
    expected = DateTime.new(2017, 12, 14, 16, 34, 33)
    _(subject.expires_date).must_equal expected
  end

  it 'returns expiration_intent' do
    _(subject.expiration_intent).must_equal 4
  end

  it 'returns expiration_intent_string' do
    _(subject.expiration_intent_string).must_equal 'unavailable_product'
  end

  it 'returns is_in_billing_retry_period' do
    _(subject.is_in_billing_retry_period).must_equal 0
  end

  it 'check in_billing_retry_period?' do
    _(subject.in_billing_retry_period?).must_equal false
  end

  it 'returns is_trial_period' do
    _(subject.is_trial_period).must_equal false
  end

  it 'check trial_period?' do
    _(subject.trial_period?).must_equal false
  end

  it 'returns cancellation_date' do
    expected = DateTime.new(2017, 7, 27, 0, 55, 46)
    _(subject.cancellation_date).must_equal expected
  end

  it 'returns cancellation_reason string' do
    _(subject.cancellation_reason_string).must_equal 'app_issue'
  end

  it 'returns cancellation_reason' do
    expected = 1
    _(subject.cancellation_reason).must_equal expected
  end

  it 'returns app_item_id' do
    _(subject.app_item_id).must_equal 0
  end

  it 'returns version_external_identifier' do
    _(subject.version_external_identifier).must_equal 3
  end

  it 'returns web_order_line_item_id' do
    _(subject.web_order_line_item_id).must_equal '1000000037216020'
  end

  it 'returns auto_renew_status' do
    _(subject.auto_renew_status).must_equal 0
  end

  it 'check will_renew?' do
    _(subject.will_renew?).must_equal false
  end

  it 'returns price_consent_status' do
    _(subject.price_consent_status).must_equal 1
  end

  it 'check price_consented?' do
    _(subject.price_consented?).must_equal true
  end

  it 'check expired?' do
    _(subject.expired?).must_equal true
  end

  it 'cancelled?' do
    _(subject.cancelled?).must_equal true
  end
end
