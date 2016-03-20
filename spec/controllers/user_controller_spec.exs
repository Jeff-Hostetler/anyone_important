defmodule AnyoneImportant.UserControllerSpec do
  use ESpec.Phoenix, controller: AnyoneImportant.UserController
  alias AnyoneImportant.User
  alias AnyoneImportant.Repo

  describe "index" do
    let :user do
      %User{name: "J Hizzo", email: "jhizzo@example.com"}
      |> Repo.insert
    end

    let :all_users do
      Repo.all(User)
    end

    subject do: action :index

    it do: should be_successful
    it do: should have_http_status(:ok)
    it do: should render_template("index.html")
    it do: should have_in_assigns(all_users: all_users)
  end
end