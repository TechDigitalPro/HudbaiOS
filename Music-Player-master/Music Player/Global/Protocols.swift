import Foundation
import UIKit

protocol ScrollViewContainingDelegate: NSObject {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    func refresh()
}

protocol ScrollViewContained {
    var scrollDelegate: ScrollViewContainingDelegate? { get set }
}

protocol AddPlayListDelegate {
    func dismissed()
}


protocol ToastDelegate {
    func dismissed()
}

protocol PlayerDelegate {
    func play(index: Int, type: Int)
}



