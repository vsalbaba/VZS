if Rails.env == 'production' then
  CURRENT_VERSION=`git describe --abbrev=0`.strip
else
  CURRENT_VERSION=`git rev-parse HEAD`.strip
end 

begin
  REVISION = File.read("#{Rails.root}/REVISION").read.strip.to_s
rescue
  REVISION = "development"
end
