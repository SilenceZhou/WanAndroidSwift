//
//  ProjectCell.swift
//  WanAndroidSwift
//
//  Created by SilenceZhou on 2019/12/12.
//  Copyright © 2019 zhouyun. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {
    
    
    lazy var titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.font = UIFont.systemFont(ofSize: 16)
        return titleLbl
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setupUI()
        
    }
    
    func setupUI() {
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
