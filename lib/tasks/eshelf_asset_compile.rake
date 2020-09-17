# Customized from recommendation on post: https://bibwild.wordpress.com/2014/10/02/non-digested-asset-names-in-rails-4-your-options/
# And this gist: https://raw.githubusercontent.com/team-umlaut/umlaut/5edcc609389edf833a79caa6f3ef92982312f0c5/lib/tasks/umlaut_asset_compile.rake
#
# Rails4 doesn't create un-fingerprinted assets anymore, but we
# need a couple for eshelf's API. Let's try to hook in and make
# symlinks.


# Every time assets:precompile is called, trigger eshelf:create_non_digest_assets afterwards.
Rake::Task["assets:precompile"].enhance do
  Rake::Task["eshelf:create_non_digest_assets"].invoke
end

namespace :eshelf do

  # This seems to be basically how ordinary asset precompile
  # is logging, ugh.
  logger = Logger.new($stderr)

  # Based on suggestion at https://github.com/rails/sprockets-rails/issues/49#issuecomment-20535134
  # but limited to files in umlaut's namespaced asset directories.
  task :create_non_digest_assets => :"assets:environment"  do
    manifest_path = Dir.glob(File.join(Rails.root, 'public', Rails.application.config.assets.prefix, '.sprockets-manifest-*.json')).first
    # binding.pry
    manifest_data = JSON.load(File.new(manifest_path))

    manifest_data["assets"].each do |logical_path, digested_path|
      logical_pathname = Pathname.new logical_path
      if non_digest_named_assets.any? {|testpath| logical_pathname.fnmatch?(testpath, File::FNM_PATHNAME) }
        full_digested_path    = File.join(Rails.root, 'public', Rails.application.config.assets.prefix, digested_path)
        full_nondigested_path = File.join(Rails.root, 'public', Rails.application.config.assets.prefix, logical_path)

        logger.info "(E-Shelf) Copying to #{full_nondigested_path}"

        # Use FileUtils.copy_file with true third argument to copy
        # file attributes (eg mtime) too, as opposed to FileUtils.cp
        # Making symlnks with FileUtils.ln_s would be another option, not
        # sure if it would have unexpected issues.
        FileUtils.copy_file full_digested_path, full_nondigested_path, true
      end
    end

  end
end

def non_digest_named_assets
  @non_digest_named_assets ||= ["records.js"]
end
