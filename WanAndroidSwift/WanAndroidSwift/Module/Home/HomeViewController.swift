//
//  HomeViewController.swift
//  WanAndroidSwift
//
//  Created by zhouyun on 2019/11/21.
//  Copyright © 2019 zhouyun. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = { [unowned self] in
        
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    lazy var bannerView: LLCycleScrollView = {
        
        let bannerView = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200))
        bannerView.pageControlBottom = 20
        bannerView.autoScroll = true // 自动滚动
        bannerView.infiniteLoop = true // 无线滚动
        bannerView.autoScrollTimeInterval = 3.0 // 滚动间隔
        
        // bannerView.placeHolderImage = #UIImage // 等待数据状态显示的占位图
        //bannerView.coverImage = #UIImage // 如果没有数据的时候，使用的封面图

        // 设置图片显示方式=UIImageView的ContentMode
        bannerView.imageViewContentMode = .scaleToFill

        // 设置滚动方向（ vertical || horizontal ）
        bannerView.scrollDirection = .horizontal

        // 设置当前PageControl的样式 (.none, .system, .fill, .pill, .snake)
        bannerView.customPageControlStyle = .pill

        // 非.system的状态下，设置PageControl的tintColor
        bannerView.customPageControlInActiveTintColor = UIColor.brown
        bannerView.customPageControlTintColor = UIColor.lightGray

        // 设置.system系统的UIPageControl当前显示的颜色
        bannerView.pageControlCurrentPageColor = UIColor.red

        // 非.system的状态下，设置PageControl的间距(默认为8.0)
        bannerView.customPageControlIndicatorPadding = 8.0

        // 设置PageControl的位置 (.left, .right 默认为.center)
        bannerView.pageControlPosition = .center

        // 背景色
        bannerView.collectionViewBackgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        return bannerView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor
        title = "首页"
        
        setUpMainView()
        
        Observable.zip(NetworkTools.rx_getBanner(),
                   NetworkTools.rx_getWXarticle(),
                   NetworkTools.rx_getRecommandProject())
        .subscribe(onNext: { [unowned self] (banner, article, project)   in
            
            if let arr = banner.data {
                self.bannerView.imagePaths = arr.map { datum in datum.imagePath }
            }
            
            
        }, onError: { error in
            print(error)
        }, onCompleted: { [unowned self] in
            
            self.tableView.es.stopPullToRefresh();
            
        }).disposed(by: disposeBag)
        
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        Observable.zip(NetworkTools.rx_getBanner(),
                       NetworkTools.rx_getWXarticle(),
                       NetworkTools.rx_getRecommandProject())
            .subscribe(onNext: { (banner, article, project) in
                
                
                
                if let arr = banner.data {
                    
                 let imagePaths = arr.map { datum in datum.imagePath }
                    print("imagePaths = \(imagePaths)")
                    
                }
                
                
            }, onError: { error in
                print(error)
            }, onCompleted: { [unowned self] in
                
                self.tableView.es.stopPullToRefresh();
                
            }).disposed(by: disposeBag)
        
    }
}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
}

extension HomeViewController {
    
    func setUpMainView() {
        view.addSubview(tableView)
        tableView.tableHeaderView = bannerView

        tableView.es.addPullToRefresh { [unowned self] in
            // 延迟5秒操作
            // https://www.hangge.com/blog/cache/detail_2169.html
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.tableView.es.stopPullToRefresh()
                self.tableView.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: true)
            }
        }
    }
}
