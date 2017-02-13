module Puppet::Parser::Functions
  newfunction(:get_nfs_shares, :type => :rvalue) do |args|
    data = args[0]
    backend_number = args[1]
    nb_share = data['nb_share' + backend_number.to_s].to_i
    shares = ''
    nb_share.downto(1) { |share|
      shares += data['nfs_server_share' + backend_number.to_s + share.to_s] + "\n"
    }
    return shares
  end
end

