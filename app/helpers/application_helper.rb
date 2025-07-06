module ApplicationHelper
    def back_link_path
      # リファラーが存在し、t.coからのリンクでない場合はリファラーを使用
      if request.referer.present? && !request.referer.include?("t.co")
        request.referer
      else
        root_path
      end
    end

  def default_meta_tags(url: "https://res.cloudinary.com/desktest/image/upload/v1751531494/ititas_xvfkax.png")
    {
      site: "いちたす",
      title: "いちたす",
      reverse: true,
      charset: "utf-8",
      description: "「いちたす」は、1日1つのタスクを完了させるシンプルなタスク管理アプリです。",
      canonical: request.original_url,
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: "website",
        url: request.original_url,
        image: url,
        locale: "ja-JP"
      },
        twitter: {
        card: "summary_large_image",
        image: url
      }
    }
  end
end
