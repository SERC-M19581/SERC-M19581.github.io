module RenderAltPage
    class Generator < Jekyll::Generator
        priority :highest
        safe true

        def generate(site)
            site.pages.each do |page|
                if page.data['alt_layout'] && page.data['alt_url']
                    alt_layout = page.data['alt_layout']
                    alt_url = page.data['alt_url']
                    alt_page = Jekyll::PageWithoutAFile.new(site, site.source, File.dirname(page.path), File.basename(page.path))

                    alt_page.content = page.content
                    alt_page.data = page.data.dup
                    alt_page.data.delete('alt_layout')
                    alt_page.data.delete('alt_url')
                    alt_page.data['layout'] = alt_layout
                    alt_page.data['permalink'] = alt_url
                    alt_page.data['nav_exclude'] = true
                    alt_page.data['parent'] = nil
                    alt_page.data['grand_parent'] = nil

                    site.pages << alt_page
                end
            end
        end
    end
end
