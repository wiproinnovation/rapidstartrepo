node.set["nginx"]["worker_processes"]     = 4
node.set["nginx"]["worker_connections"]   = 768
node.set["nginx"]["default_site_enabled"] = false

include_recipe "nginx::default"

ssl_dir = ::File.join(node["nginx"]["dir"], "ssl")
directory ssl_dir do
  owner "root"
  group "root"
  mode  "0600"
end

domain_name = node["wipro"]["com"]
bash "generate-ssl-files" do
  cwd   ssl_dir
  flags "-e"
  code <<-EOS
    DOMAIN=#{domain_name}
    openssl genrsa -out $DOMAIN.key 4096
    openssl req -new -batch -subj "/CN=$DOMAIN" -key $DOMAIN.key -out $DOMAIN.csr
    openssl x509 -req -days 365 -in $DOMAIN.csr -signkey $DOMAIN.key -out $DOMAIN.crt
    rm $DOMAIN.csr
  EOS
  notifies :reload, "service[nginx]"
  not_if   { ::File.exists?(::File.join(ssl_dir, domain_name + ".crt")) }
end

template "#{node["nginx"]["dir"]}/sites-available/wiproinnovation" do
  source "nginx_site.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  variables(:domain_name => domain_name)
end

nginx_site "practicingruby" do
  enable true
end