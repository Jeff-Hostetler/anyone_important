defmodule AnyoneImportant.UserControllerSpec do
  use ESpec.Phoenix, controller: AnyoneImportant.UserController
  alias AnyoneImportant.User
  alias AnyoneImportant.Repo

  describe "index" do
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
    it "creates the user with valid params" do
      create_action = action(
        :create,
        %{"user" => %{"name" => "My Guy", "email" => "test@example.com"}}
      )

      expect create_action |> to(have_in_flash(info: "You are now on the list."))
      expect create_action |> to(be_redirection)
      expect(Enum.count(Repo.all(User))).to eq 1

      created_user = Repo.get_by(User, name: "My Guy")

      expect(created_user.email).to eq "test@example.com"
    end
  end
end