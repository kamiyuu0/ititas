module ApplicationHelper

  def default_meta_tags(url: "https://res.cloudinary.com/desktest/image/upload/v1751523007/ititas_ragzok.png")
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