module Api
  class PlaywrightsController < ApiController
    def index
      @playwrights = Playwright.all
    end

    # TODO: Add Authorization
    def update
      @playwright = Playwright.find(params[:id])
      @playwright.update!(text: params[:text])
    end

    def show
      @playwright = Playwright.find(params[:id])
    end

    def versions
      @playwrights = Playwright.find(params[:id]).last_versions
    end
  end
end
