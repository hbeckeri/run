
import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var labelTrack: UILabel!
    @IBOutlet weak var labelArtistAlbum: UILabel!
    @IBOutlet weak var imgTrack: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

