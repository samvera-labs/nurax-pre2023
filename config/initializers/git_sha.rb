GIT_SHA =
    if Rails.env.production? && File.exist?('/opt/nurax/revisions.log')
      `tail -1 /opt/nurax/revisions.log`.chomp.split(" ")[3].gsub(/\)$/, '')
    elsif Rails.env.development? || Rails.env.test?
      `git rev-parse HEAD`.chomp
    else
      "Unknown SHA"
    end

BRANCH =
    if Rails.env.production? && File.exist?('/opt/nurax/revisions.log')
      `tail -1 /opt/nurax/revisions.log`.chomp.split(" ")[1]
    elsif Rails.env.development? || Rails.env.test?
      `git rev-parse --abbrev-ref HEAD`.chomp
    else
      "Unknown branch"
    end

LAST_DEPLOYED =
    if Rails.env.production? && File.exist?('/opt/nurax/revisions.log')
      deployed = `tail -1 /opt/nurax/revisions.log`.chomp.split(" ")[7]
      DateTime.parse(deployed).strftime("%e %b %Y %H:%M:%S")
    else
      "Not in deployed environment"
    end
