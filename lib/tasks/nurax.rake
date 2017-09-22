namespace :nurax do
  desc 'Loop over all objects and regenerative derivatives'
  task regenerate_derivatives: [:environment] do
    Hyrax.config.curation_concerns.each do |concern|
      concern.all.map(&:members).each do |members|
        next if members.blank?
        members.each do |member|
          # Logic here is based on https://github.com/samvera/hyrax/blob/d9bdb7086331f5bf6940fc8776490446efa25592/app/actors/hyrax/actors/file_actor.rb#L23-L34
          next unless member.is_a?(FileSet)
          if member.original_file.nil?
            Rails.logger.warn("No :original_file relation returned for FileSet (#{member.id})" )
            next
          end
          wrapper = JobIoWrapper.find_by(file_set_id: member.id)
          path_hint = wrapper.uploaded_file ? wrapper.uploaded_file.uploader.path : wrapper.path
          Rails.logger.debug("Regenerating derivatives for FileSet #{member.id} in the background")
          CharacterizeJob.perform_later(member, member.original_file.id, path_hint)
        end
      end
    end
  end
end
