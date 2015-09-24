class Playwright < ActiveRecord::Base
  has_paper_trail

  def last_versions
    versions.map(&:reify)
  end
end
