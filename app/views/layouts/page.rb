class Views::Layouts::Page < Views::Base
  needs :current_user
  needs :current_path

  def content
    html do
      div class: 'navBar' do
        nav_bar
      end

      div class: 'sideBar' do
        side_bar
      end

      div class: 'main' do
        main
      end
    end
  end

  def side_bar
    widget Views::Layouts::Sidebar.new(current_user: current_user, current_path: current_path)
  end

  def nav_bar
    widget Views::Layouts::Navbar.new(current_user: current_user, current_path: current_path)
  end

  def main
    p "This page intentionally left blank."
  end
end
