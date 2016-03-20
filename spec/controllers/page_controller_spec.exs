defmodule AnyoneImportant.PageControllerSpec do
  use ESpec.Phoenix, controller: AnyoneImportant.PageController

  describe "index" do
    subject do: action :index

    it do: should be_successful
    it do: should have_http_status(:ok)
    it do: should render_template("index.html")
  end


  describe "help" do
    subject do: action :help

    it do: should be_successful
    it do: should have_http_status(:ok)
    it do: should render_template("help.html")
  end
end