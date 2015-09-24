class PlaywrightsController < ApplicationController
  def index
    # TODO: Should be replaced with a list of created playwrights.
    # Afterwards there'll be a #show to select the specific playwright.
    @playwright = Playwright.first_or_create
    @versions = @playwright.last_versions.sort_by(&:updated_at).reverse!
    @user = random_user
  end

  private

  def random_user
    User.offset(rand(User.count)).first
  end
end
