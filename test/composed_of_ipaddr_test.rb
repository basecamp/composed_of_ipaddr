require 'test_helper'

class ComposedOfIpaddrTest < ActiveSupport::TestCase
  class Model < ActiveRecord::Base
    establish_connection :adapter => 'sqlite3', :database => 'test.sqlite3'

    if !connection.table_exists?(table_name)
      connection.create_table(table_name) { |t| t.column :ipv4, 'int unsigned' }
    end

    include ComposedOfIpaddr
  end

  test 'converts and constructs' do
    ip = IPAddr.new('1.2.3.4')
    model = Model.new(:ipaddr => ip.to_s)
    assert_equal ip, model.ipaddr
    assert_equal ip.to_i, model.attributes['ipv4']

    model.ipaddr = ip.to_i
    assert_equal ip, model.ipaddr

    model.save!
    model.reload
    assert_equal ip.to_i, model.attributes['ipv4']
    assert_equal ip, model.ipaddr
  end
end
