$: << 'cf_spec'
require 'bundler/setup'
require 'json'
require 'fileutils'

describe "New Relic Installer" do
  let(:buildpack_dir) { File.join(File.expand_path(File.dirname(__FILE__)), '..', '..') }

  before do
    ENV["BP_DIR"] = buildpack_dir
  end

  context 'vcap services contains newrelic' do
    before do
      vcap_services = {"newrelic":[{
        "credentials": {
          "licenseKey": "new_relic_license_key_set_by_service_binding"
        }}]
      }
      ENV["VCAP_SERVICES"] = vcap_services.to_json
    end

    after do
      ENV["VCAP_SERVICES"] = nil
    end

    it "sets the NEW_RELIC_LICENSE_KEY variable" do
      buildpack_dir = File.join(File.expand_path(File.dirname(__FILE__)), '..', '..')
      Dir.chdir(buildpack_dir) do
        new_relic_key = `source lib/vendor/new_relic/install.sh && echo $NEW_RELIC_LICENSE_KEY`.strip
        expect(new_relic_key).to eq("new_relic_license_key_set_by_service_binding")
      end
    end
  end

  context 'vcap services does not contain newrelic' do
    it "sets the NEW_RELIC_LICENSE_KEY variable" do
      Dir.chdir(buildpack_dir) do
        new_relic_key = `source lib/vendor/new_relic/install.sh && echo $NEW_RELIC_LICENSE_KEY`.strip
        expect(new_relic_key).to eq("")
      end
    end
  end
end
