require 'spec_helper'

describe 'solr::core', :type => :define do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end


        context 'solr::core define without any parameters' do
          let(:params) {{ }}
          let(:title) { "test" }

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_solr__core('test') }

          it { is_expected.to contain_exec('create test core') }
        end
      end
    end
  end
end
