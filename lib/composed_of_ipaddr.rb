require 'active_record'
require 'concerning'
require 'ipaddr'

# Store IPs as 4-byte integers in the db. Saves space, indexes well.
# Pardon these ugly implementation contortions. In our code, just work
# with :ipaddr using '1.2.3.4' strings and expect implicit coercion.
#
# Expects a column named 'ipv4' with type 'int unsigned'
concern :ComposedOfIpaddr do
  included do
    composed_of :ipaddr, :class_name => 'IPAddr', :mapping => %w(ipv4 to_i), :allow_nil => true,
      :constructor  => lambda { |ip| ::ComposedOfIpaddr.convert_to_ipaddr ip },
      :converter    => lambda { |ip| ::ComposedOfIpaddr.convert_to_ipaddr ip }

    scope :by_ipaddr, lambda { |ip| where :ipv4 => ::ComposedOfIpaddr.convert_to_ipv4(ip) if ip }
  end

  # 0.0.0.0
  def global?
    ipv4.try :zero?
  end

  def per_ip?
    !global?
  end

  def self.convert_to_ipaddr(ip)
    case ip
    when IPAddr; ip
    when Integer; IPAddr.new(ip, Socket::AF_INET)
    else IPAddr.new(ip)
    end
  end

  def self.convert_to_ipv4(ip)
    if ip.respond_to? :map
      ip.map { |i| convert_to_ipaddr i }.map &:to_i
    else
      convert_to_ipaddr(ip).to_i
    end
  end
end
