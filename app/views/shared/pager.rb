class Views::Shared::Pager < Views::Base
  needs :start
  needs :count
  needs :path_gen

  def content
    div class: 'pager' do
      table {tbody {tr {
        (0...count).each do |index|
          td do
            link_to index, path_gen.call(index)
          end
        end
      }}}
    end if count > 1
  end
end

