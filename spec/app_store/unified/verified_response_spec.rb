# frozen_string_literal: true

require 'spec_helper'

describe CandyCheck::AppStore::Unified::VerifiedResponse do
  subject { CandyCheck::AppStore::Unified::VerifiedResponse.new(response) }

  describe 'when response does not include a subscription' do
    let(:response) do
      {
        'status' => 0,
        'environment' => 'Production',
        'receipt' => {
          'bundle_id' => 'com.app.bundle_id',
          'application_version' => '6',
          'receipt_creation_date' => '2017-07-25 00:55:46 Etc/GMT',
          'original_application_version' => '1.0',
          'in_app' => [
            {
              'quantity' => '1',
              'product_id' => 'com.app.product_id',
              'transaction_id' => '1000800359115195',
              'original_transaction_id' => '1000800359115195',
              'purchase_date' => '2017-12-14 16:54:33 Etc/GMT',
              'original_purchase_date' => '2017-12-14 16:29:35 Etc/GMT'
            }
          ]
        }
      }
    end

    let(:app_receipt_class) { CandyCheck::AppStore::Unified::AppReceipt }

    it '#subscription?' do
      _(subject.subscription?).must_be_false
    end

    it '#receipt' do
      _(subject.receipt).must_be_instance_of(app_receipt_class)
    end

    it '#pending_renewal_info' do
      _(subject.pending_renewal_info).must_be :empty?
    end
  end

  describe 'when respose includes a subscription' do
    let(:response) do
      {
        'status' => 0,
        'environment' => 'Production',
        'receipt' => {
          'bundle_id' => 'com.app.bundle_id',
          'application_version' => '6',
          'receipt_creation_date' => '2017-07-25 00:55:46 Etc/GMT',
          'original_application_version' => '1.0',
          'in_app' => [
            {
              'quantity' => '1',
              'product_id' => 'com.app.product_id',
              'transaction_id' => '1000800359115195',
              'original_transaction_id' => '1000800359115195',
              'purchase_date' => '2017-12-14 16:54:33 Etc/GMT',
              'original_purchase_date' => '2017-12-14 16:29:35 Etc/GMT',
              'expires_date' => '2017-12-14 16:59:33 Etc/GMT',
              'web_order_line_item_id' => '1000000037215974',
              'is_trial_period' => 'false',
              'is_in_intro_offer_period' => 'false'
            },
            {
              'quantity' => '1',
              'product_id' => 'com.app.alt.product_id',
              'transaction_id' => '1000800359115199',
              'original_transaction_id' => '1000800359115199',
              'purchase_date' => '2018-01-14 16:54:33 Etc/GMT',
              'original_purchase_date' => '2018-01-14 16:29:35 Etc/GMT',
              'expires_date' => '2018-01-14 16:59:33 Etc/GMT',
              'web_order_line_item_id' => '1000000037215975',
              'is_trial_period' => 'false',
              'is_in_intro_offer_period' => 'false'
            },
            {
              'quantity' => '1',
              'product_id' => 'com.app.alt.product_id',
              'transaction_id' => '1000800359205199',
              'original_transaction_id' => '1000800359115199',
              'purchase_date' => '2018-02-14 16:54:33 Etc/GMT',
              'original_purchase_date' => '2018-02-14 16:29:35 Etc/GMT',
              'expires_date' => '2018-02-14 16:59:33 Etc/GMT',
              'web_order_line_item_id' => '1000000039215975',
              'is_trial_period' => 'false',
              'is_in_intro_offer_period' => 'false'
            }
          ]
        },
        'latest_receipt_info' => [
          {
            'quantity' => '1',
            'product_id' => 'com.app.product_id',
            'transaction_id' => '1000800359115195',
            'original_transaction_id' => '1000800359115195',
            'purchase_date' => '2017-12-14 16:54:33 Etc/GMT',
            'original_purchase_date' => '2017-12-14 16:29:35 Etc/GMT',
            'expires_date' => '2017-12-14 16:59:33 Etc/GMT',
            'web_order_line_item_id' => '1000000037215974',
            'is_trial_period' => 'false',
            'is_in_intro_offer_period' => 'false'
          },
          {
            'quantity' => '1',
            'product_id' => 'com.app.product_id',
            'transaction_id' => '1000000359846977',
            'original_transaction_id' => '1000800359115195',
            'purchase_date' => '2017-12-15 08:17:54 Etc/GMT',
            'original_purchase_date' => '2017-12-14 16:29:35 Etc/GMT',
            'expires_date' => '2017-12-15 08:22:54 Etc/GMT',
            'web_order_line_item_id' => '1000000037216020',
            'is_trial_period' => 'false',
            'is_in_intro_offer_period' => 'false'
          },
          {
            'quantity' => '1',
            'product_id' => 'com.app.alt.product_id',
            'transaction_id' => '1000000359847977',
            'original_transaction_id' => '1000800359115199',
            'purchase_date' => '2018-01-15 08:17:54 Etc/GMT',
            'original_purchase_date' => '2018-01-14 16:29:35 Etc/GMT',
            'expires_date' => '2018-01-15 08:22:54 Etc/GMT',
            'web_order_line_item_id' => '1000000037216029',
            'is_trial_period' => 'false',
            'is_in_intro_offer_period' => 'false'
          }
        ],
        'latest_receipt' => 'base 64',
        'pending_renewal_info' => [
          {
            'expiration_intent' => '4',
            'auto_renew_product_id' => 'com.app.product_id',
            'original_transaction_id' => '1000800359115195',
            'is_in_billing_retry_period' => '0',
            'product_id' => 'com.app.product_id',
            'auto_renew_status' => '0'
          },
          {
            'expiration_intent' => '1',
            'auto_renew_product_id' => 'com.app.alt.product_id',
            'original_transaction_id' => '1000800359115199',
            'is_in_billing_retry_period' => '0',
            'product_id' => 'com.app.alt.product_id',
            'auto_renew_status' => '0'
          }
        ]
      }
    end

    let(:app_receipt_class) { CandyCheck::AppStore::Unified::AppReceipt }
    let(:in_app_class) { CandyCheck::AppStore::Unified::InAppReceipt }

    it '#subscription?' do
      _(subject.subscription?).must_be_true
    end

    it '#receipt' do
      _(subject.receipt).must_be_instance_of(app_receipt_class)
    end

    it '#latest_receipt_info' do
      _(subject.latest_receipt_info.size).must_equal 3
      _(subject.latest_receipt_info.last).must_be_instance_of(in_app_class)
    end

    it '#pending_renewal_info' do
      _(subject.pending_renewal_info.size).must_equal 2
      _(subject.pending_renewal_info.last).must_be_instance_of(in_app_class)
    end

    it '#in_app' do
      _(subject.in_app.size).must_equal 3
    end

    it '#subscriptions' do
      _(subject.subscriptions.size).must_equal 2
    end

    it '#latest_subscription_info' do
      _(subject.latest_subscription_info('1000800359115195')).must_be_instance_of(in_app_class)
      _(subject.latest_subscription_info('1000800359115195').transaction_id).must_equal '1000000359846977'
    end

    it '#pending_renewal_transaction' do
      _(subject.pending_renewal_transaction('1000800359115195', nil)).must_be_instance_of(in_app_class)
      _(subject.pending_renewal_transaction('1000800359115195', nil).is_in_billing_retry_period).must_equal 0
    end

    it '#pending_renewal_transaction prefers an exact OTI match over an earlier product_id match' do
      renewal = subject.pending_renewal_transaction('1000800359115199', 'com.app.product_id')
      _(renewal.original_transaction_id).must_equal '1000800359115199'
    end

    it '#pending_renewal_transaction falls back to product_id when the OTI is unknown' do
      renewal = subject.pending_renewal_transaction('unknown', 'com.app.alt.product_id')
      _(renewal.original_transaction_id).must_equal '1000800359115199'
    end
  end

  describe '#total_receipts' do
    let(:response) do
      { 'environment' => 'Production', 'receipt' => { 'in_app' => in_app }, 'latest_receipt_info' => latest }
    end
    let(:latest) { [] }
    let(:in_app) { [] }

    def raw(transaction_id, web_order_line_item_id = :missing)
      { 'transaction_id' => transaction_id }.tap do |attributes|
        attributes['web_order_line_item_id'] = web_order_line_item_id unless web_order_line_item_id == :missing
      end
    end

    def total
      subject.total_receipts.map(&:attributes)
    end

    describe 'when both sides carry a web_order_line_item_id' do
      let(:latest) { [raw('A', '1')] }
      let(:in_app) { [raw('B', '1'), raw('A', '2')] }

      it 'drops the in_app receipt with the same id and keeps one with another id' do
        _(total).must_equal [raw('A', '1'), raw('A', '2')]
      end
    end

    describe 'when only the in_app receipt has no web_order_line_item_id' do
      let(:latest) { [raw('A', '1')] }
      let(:in_app) { [raw('A'), raw('B')] }

      it 'matches by transaction_id' do
        _(total).must_equal [raw('A', '1'), raw('B')]
      end
    end

    describe 'when only the latest receipt has no web_order_line_item_id' do
      let(:latest) { [raw('A')] }
      let(:in_app) { [raw('A', '1'), raw('B', '2')] }

      it 'matches by transaction_id' do
        _(total).must_equal [raw('A'), raw('B', '2')]
      end
    end

    describe 'when neither side has a web_order_line_item_id' do
      let(:latest) { [raw('A')] }
      let(:in_app) { [raw('A'), raw('B')] }

      it 'matches by transaction_id' do
        _(total).must_equal [raw('A'), raw('B')]
      end
    end

    describe 'when the in_app web_order_line_item_id is blank' do
      let(:latest) { [raw('A', '5'), raw('B', '6'), raw('C', '7')] }
      let(:in_app) { [raw('A', ''), raw('B', ' '), raw('C', nil), raw('D', '')] }

      it 'counts it as missing and matches by transaction_id' do
        _(total).must_equal [raw('A', '5'), raw('B', '6'), raw('C', '7'), raw('D', '')]
      end
    end

    describe 'when the latest web_order_line_item_id is blank' do
      let(:latest) { [raw('A', ''), raw('B', ' '), raw('C', nil)] }
      let(:in_app) { [raw('A', '1'), raw('B', '2'), raw('C', '3'), raw('D', '4')] }

      it 'counts it as missing and matches by transaction_id' do
        _(total).must_equal [raw('A', ''), raw('B', ' '), raw('C', nil), raw('D', '4')]
      end
    end

    describe 'when the transaction_id is nil on both sides' do
      let(:latest) { [raw(nil)] }
      let(:in_app) { [raw(nil), {}] }

      it 'matches nil with nil' do
        _(total).must_equal [raw(nil)]
      end
    end

    describe 'with duplicates' do
      let(:latest) { [raw('A', '1'), raw('A', '1')] }
      let(:in_app) { [raw('B'), raw('B'), raw('C', '2'), raw('C', '2')] }

      it 'keeps every latest receipt and every unmatched in_app receipt' do
        _(total).must_equal [raw('A', '1'), raw('A', '1'), raw('B'), raw('B'), raw('C', '2'), raw('C', '2')]
      end
    end

    describe 'without latest_receipt_info' do
      let(:response) { { 'environment' => 'Production', 'receipt' => { 'in_app' => in_app } } }
      let(:in_app) { [raw('B', '2'), raw('A')] }

      it 'keeps every in_app receipt in its order' do
        _(total).must_equal [raw('B', '2'), raw('A')]
        _(subject.total_receipts).wont_be_same_as subject.in_app
      end
    end

    describe 'without in_app receipts' do
      let(:latest) { [raw('B', '2'), raw('A')] }

      it 'keeps every latest receipt in its order' do
        _(total).must_equal [raw('B', '2'), raw('A')]
        _(subject.total_receipts).wont_be_same_as subject.latest_receipt_info
      end
    end

    describe 'the returned array' do
      let(:latest) { [raw('B', '2'), raw('A', '1')] }
      let(:in_app) { [raw('D'), raw('A', '1'), raw('C', '3')] }

      it 'lists latest_receipt_info first, then the unmatched in_app receipts in their order' do
        _(total).must_equal [raw('B', '2'), raw('A', '1'), raw('D'), raw('C', '3')]
      end

      it 'holds the receipt objects of the source collections' do
        _(subject.total_receipts.first).must_be_same_as subject.latest_receipt_info.first
        _(subject.total_receipts.last).must_be_same_as subject.in_app.last
      end

      it 'leaves the source collections as they were' do
        subject.total_receipts
        _(subject.latest_receipt_info.map(&:attributes)).must_equal latest
        _(subject.in_app.map(&:attributes)).must_equal in_app
      end

      it 'is the same array on a second call' do
        _(subject.total_receipts).must_be_same_as subject.total_receipts
      end
    end

    describe 'when no in_app receipt is left' do
      let(:latest) { [raw('A', '1')] }
      let(:in_app) { [raw('A', '1')] }

      it 'is not the latest_receipt_info array itself' do
        _(total).must_equal latest
        _(subject.total_receipts).wont_be_same_as subject.latest_receipt_info
      end
    end
  end

  describe '#grouped_receipts' do
    let(:response) { { 'environment' => 'Production', 'receipt' => {}, 'latest_receipt_info' => latest } }

    def raw(transaction_id, original_transaction_id, **attributes)
      attributes.transform_keys(&:to_s).merge(
        'transaction_id' => transaction_id, 'original_transaction_id' => original_transaction_id
      )
    end

    def grouped
      subject.grouped_receipts.transform_values { |receipts| receipts.map(&:transaction_id) }
    end

    describe 'grouping' do
      let(:latest) do
        [
          raw('1', 'O1', subscription_group_identifier: 'G1', expires_date: '2024-02-01 00:00:00 Etc/GMT'),
          raw('2', 'O3', expires_date: '2024-02-01 00:00:00 Etc/GMT'),
          raw('3', 'O2', subscription_group_identifier: 'G1', expires_date: '2024-03-01 00:00:00 Etc/GMT'),
          raw('4', 'O4', web_order_line_item_id: '10', product_id: 'p1', expires_date: '2024-02-01 00:00:00 Etc/GMT'),
          raw('5', 'O5', web_order_line_item_id: '11', product_id: 'p1', expires_date: '2024-03-01 00:00:00 Etc/GMT')
        ]
      end

      it 'keys each group by the original_transaction_id of its first receipt, in order of appearance' do
        _(grouped).must_equal({ 'O1' => %w(1 3), 'O3' => %w(2), 'O4' => %w(4 5) })
        _(subject.grouped_receipts.keys).must_equal %w(O1 O3 O4)
      end

      it 'returns a group by its key' do
        _(subject.subscription_receipts_by('O1').map(&:transaction_id)).must_equal %w(1 3)
        _(subject.subscription_receipts_by('O2')).must_be_nil
      end

      it 'is the same hash on a second call' do
        _(subject.grouped_receipts).must_be_same_as subject.grouped_receipts
      end
    end

    describe 'sorting receipts without a storefront' do
      let(:latest) do
        [
          raw('1', 'O1', purchase_date: '2024-01-01 00:00:00 Etc/GMT', expires_date: '2024-03-01 00:00:00 Etc/GMT'),
          raw('2', 'O1', purchase_date: '2024-02-01 00:00:00 Etc/GMT', expires_date: '2024-02-15 00:00:00 Etc/GMT'),
          raw('3', 'O1', purchase_date: '2024-02-20 00:00:00 Etc/GMT')
        ]
      end

      it 'orders by expires_date and falls back to purchase_date' do
        _(grouped).must_equal({ 'O1' => %w(2 3 1) })
      end
    end

    describe 'sorting receipts with a storefront' do
      let(:latest) do
        [
          raw('1', 'O1', storefront: 'USA', expires_date: '2024-01-20 00:00:00 Etc/GMT'),
          raw('2', 'O1', storefront: 'USA',
                         purchase_date: '2024-02-01 00:00:00 Etc/GMT', expires_date: '2024-02-15 00:00:00 Etc/GMT'),
          raw('3', 'O1', storefront: 'USA',
                         purchase_date: '2024-01-01 00:00:00 Etc/GMT', expires_date: '2024-03-01 00:00:00 Etc/GMT')
        ]
      end

      it 'orders by purchase_date and falls back to expires_date' do
        _(grouped).must_equal({ 'O1' => %w(3 1 2) })
      end
    end

    describe 'when the last receipt of a group is upgraded' do
      let(:latest) do
        [
          raw('1', 'O1', purchase_date: '2024-01-01 00:00:00 Etc/GMT', expires_date: '2024-02-01 00:00:00 Etc/GMT'),
          raw('2', 'O1', purchase_date: '2024-01-10 00:00:00 Etc/GMT', expires_date: '2024-02-10 00:00:00 Etc/GMT'),
          raw('3', 'O1', purchase_date: '2024-01-11 00:00:00 Etc/GMT', expires_date: '2024-03-01 00:00:00 Etc/GMT',
                         is_upgraded: 'true')
        ]
      end

      it 'moves the receipt before it to the end' do
        _(grouped).must_equal({ 'O1' => %w(1 3 2) })
      end
    end
  end
end
