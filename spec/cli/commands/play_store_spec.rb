# frozen_string_literal: true

require 'spec_helper'

describe CandyCheck::CLI::Commands::PlayStore do
  include WithCommand
  subject { CandyCheck::CLI::Commands::PlayStore }
  let(:arguments) { [package, product_id, token, options] }
  let(:package)    { 'the_package' }
  let(:product_id) { 'the_product' }
  let(:token)      { 'the_token' }
  let(:options)    { { 'json_key_file' => 'local/google.json' } }
  let(:authorization) { Object.new }

  before do
    authorize = proc do |json_key_file|
      @json_key_file = json_key_file
      authorization
    end
    build = proc do |**options|
      @verifier = DummyPlayStoreVerifier.new(**options)
    end
    CandyCheck::PlayStore.stub :authorization, authorize do
      CandyCheck::PlayStore::Verifier.stub :new, build do
        run_command!
      end
    end
  end

  it 'calls and outputs the verifier' do
    _(@json_key_file).must_equal 'local/google.json'
    _(@verifier.authorization).must_be_same_as authorization
    _(@verifier.arguments).must_equal({ package_name: package, product_id: product_id, token: token })
    _(out.lines).must_equal ['Hash:', { result: :stubbed }]
  end

  private

  DummyPlayStoreVerifier = Struct.new(:authorization, keyword_init: true) do
    attr_reader :arguments

    def verify_product_purchase(**arguments)
      @arguments = arguments
      { result: :stubbed }
    end
  end
end
