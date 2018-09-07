rails_env = new_resource.environment["RAILS_ENV"]
secret_key_base = new_resource.environment["SECRET_KEY_BASE"]
s3_bucked_name = new_resource.environment["S3_BUCKET_NAME"]
aws_access_key_id = new_resource.environment["AWS_ACCESS_KEY_ID"]
aws_secret_access_key = new_resource.environment["AWS_SECRET_ACCESS_KEY"]
Chef::Log.info("Precompiling assets for RAILS_ENV=#{rails_env}...")
execute "rake assets:precompile" do
  cwd release_path
  command "bundle exec rake assets:precompile"
  environment "RAILS_ENV" => rails_env, "SECRET_KEY_BASE" => secret_key_base, "S3_BUCKET_NAME" => s3_bucked_name, "AWS_ACCESS_KEY_ID" => aws_access_key_id, "AWS_SECRET_ACCESS_KEY" => aws_secret_access_key
end
