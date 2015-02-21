class Views::Layouts::Page < Views::Base
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
    widget Views::Layouts::Sidebar.new
  end

  def nav_bar
    widget Views::Layouts::Navbar.new
  end

  def main
    p "This page intentionally left blank."
  end
end
