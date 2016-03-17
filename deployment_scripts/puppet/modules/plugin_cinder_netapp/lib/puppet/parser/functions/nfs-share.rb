module Puppet::Parser::Functions
  newfunction(:get_nfs_shares, :type => :rvalue) do |args|
    data = args[0]
    nb_share = data['nb_share'].to_i
    ip = data['nfs_server_ip']
    shares = ''
    nb_share.downto(1) { |share|
      shares += ip + ':' + data['nfs_server_share' + share.to_s] + "\n"
    }
    return shares
  end
end

