require 'spec_helper'

describe 'haproxy::listen' do
  let(:title) { 'tyler' }
  let(:facts) {{ :ipaddress => '1.1.1.1' }}
  context "when only one port is provided" do
    let(:params) do
      {
        :name  => 'croy',
        :ports => '18140'
      }
    end

    it { should contain_concat__fragment('croy_listen_block').with(
      'order'   => '20-croy-00',
      'target'  => '/etc/haproxy/haproxy.cfg',
      'content' => "listen croy\n\n  bind 1.1.1.1:18140\n\n  balance  roundrobin\n  option  tcplog\n  option  ssl-hello-chk\n"
    ) }
  end
  context "when an array of ports is provided" do
    let(:params) do
      {
        :name      => 'apache',
        :ipaddress => '23.23.23.23',
        :ports     => [
          '80',
          '443',
        ]
      }
    end

    it { should contain_concat__fragment('apache_listen_block').with(
      'order'   => '20-apache-00',
      'target'  => '/etc/haproxy/haproxy.cfg',
      'content' => "listen apache\n\n  bind 23.23.23.23:80\n\n  bind 23.23.23.23:443\n\n  balance  roundrobin\n  option  tcplog\n  option  ssl-hello-chk\n"
    ) }
  end
  context "when a comma-separated list of ports is provided" do
    let(:params) do
      {
        :name      => 'apache',
        :ipaddress => '23.23.23.23',
        :ports     => '80,443'
      }
    end

    it { should contain_concat__fragment('apache_listen_block').with(
      'order'   => '20-apache-00',
      'target'  => '/etc/haproxy/haproxy.cfg',
      'content' => "listen apache\n\n  bind 23.23.23.23:80\n\n  bind 23.23.23.23:443\n\n  balance  roundrobin\n  option  tcplog\n  option  ssl-hello-chk\n"
    ) }
  end
end
