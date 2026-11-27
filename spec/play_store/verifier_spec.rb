# frozen_string_literal: true

require 'spec_helper'

describe CandyCheck::PlayStore::Verifier do
  subject { CandyCheck::PlayStore::Verifier.new(authorization: authorization) }
  let(:authorization) { Object.new }
  let(:package_name)  { 'the_package' }
  let(:token)         { 'the_token' }
  let(:result)        { Object.new }

  it 'verifies a product purchase' do
    with_mocked_verification(CandyCheck::PlayStore::ProductPurchases::ProductVerification) do
      _(
        subject.verify_product_purchase(package_name: package_name, product_id: 'the_product', token: token)
      ).must_be_same_as result
    end
    _(@verification.options).must_equal(
      { package_name: package_name, product_id: 'the_product', token: token, authorization: authorization }
    )
  end

  it 'verifies a subscription purchase' do
    with_mocked_verification(CandyCheck::PlayStore::SubscriptionPurchases::SubscriptionVerification) do
      _(
        subject.verify_subscription_purchase(
          package_name: package_name, subscription_id: 'the_subscription', token: token
        )
      ).must_be_same_as result
    end
    _(@verification.options).must_equal(
      { package_name: package_name, subscription_id: 'the_subscription', token: token, authorization: authorization }
    )
  end

  private

  def with_mocked_verification(verification_class, &block)
    build = proc do |**options|
      @verification = DummyPlayStoreVerification.new(options, result)
    end
    verification_class.stub :new, build, &block
  end

  DummyPlayStoreVerification = Struct.new(:options, :result) do
    def call!
      result
    end
  end
end
