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

  describe "create" do
    subject do: action(:create, %{"user" => %{"name" => "My Guy", "email" => "test@example.com"}})
    it do: should have_in_flash info: "You are now on the list."
    it do: should be_redirection

    it "creates the user with valid params" do
       action(:create, %{"user" => %{"name" => "My Guy", "email" => "test@example.com"}})

       expect(Enum.count(Repo.all(User))).to eq 1

       created_user = Repo.get_by(User, name: "My Guy")

       expect(created_user.email).to eq "test@example.com"
    end
  end
end