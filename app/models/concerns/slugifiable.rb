module Slugify
  module InstanceMethods
    def slug
      name.gsub(/\s/,'-').downcase 
    end

    def unslug(slug)
      slug.to_s.gsub(/-/,' ').titleize
    end
  end

  module ClassMethods

    def find_by_slug(slug)
      self.all.find { |name| name.slug == slug}
    end

  end
end
