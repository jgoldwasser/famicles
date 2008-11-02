module PrearrivalsHelper
  def add_stat_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :preg_stats_body, :partial => "pregnancy_stat", :object => PregnancyStat.new
    end
  end
end
