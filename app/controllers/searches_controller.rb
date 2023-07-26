class SearchesController < ApplicationController
  def search
    # 選択したmodelを@modelに代入
    @model = params['search']['model']
    # 選択したvalueを@valueに代入
    @value = params['search']['value']
    # 選択したhowを@howに代入
    @how = params['search']['how']
    # @datasに最終的な検索結果が入ります
    # search_forの引数にインスタンス変数を定義
    @datas = search_for(@how, @model, @value)
  end

  private

  # 完全一致
  def match(model, value)
    case model
    when 'user'
      User.where(name: value)
    when 'post'
      Post.where(title: value)
    end
  end

  # 前方一致
  def forward(model, value)
    case model
    when 'user'
      User.where('name LIKE ?', "#{value}%")
    when 'post'
      Post.where('title LIKE ?', "#{value}%")
    end
  end

  # 後方一致
  def backward(model, value)
    case model
    when 'user'
      User.where('name LIKE ?', "%#{value}")
    when 'post'
      Post.where('title LIKE ?', "%#{value}")
    end
  end

  # 部分一致
  def partical(model, value)
    case model
    when 'user'
      User.where('name LIKE ?', "%#{value}%")
    when 'post'
      Post.where('title LIKE ?', "%#{value}%")
    end
  end

  # howの中身がどれなのか探す処理
  def search_for(how, model, value)
    case how
    when 'match'
      match(model, value)
    when 'forward'
      forward(model, value)
    when 'backward'
      backward(model, value)
    when 'partical'
      partical(model, value)
    end
  end
end
