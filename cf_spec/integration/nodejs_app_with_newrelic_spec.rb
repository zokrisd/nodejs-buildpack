$: << 'cf_spec'
require 'spec_helper'

describe 'CF NodeJS Buildpack' do
  subject(:app) { Machete.deploy_app(app_name) }
  let(:browser) { Machete::Browser.new(app) }

  after do
    Machete::CF::DeleteApp.new.execute(app)
  end

  context 'deploying a NodeJS app with NewRelic' do
    let(:app_name) { 'node_web_app_with_newrelic' }

    it 'logs that it is installing NewRelic' do
      expect(app).to have_logged('Installing NewRelic')
    end
  end
end
