// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI
import UIKit

struct DemoUnwindSecondView: View {
	class ViewModel {
		var unwind: () -> ()  // unwind action
		init(_ unwind: @escaping () -> () = {}) {
			self.unwind = unwind
		}
	}

	var vm: ViewModel      // reference to view model
	var body: some View {
		Button(action: {
			vm.unwind()           // << here !!
		}) {
			Image("TopLeft")
				.renderingMode(.original)
				.resizable()
				.scaledToFit()
				.frame(width: 15, height: 15)
		}
	}
}

class ChildHostingController: UIHostingController<DemoUnwindSecondView> {

	required init?(coder: NSCoder) {
		let viewModel = DemoUnwindSecondView.ViewModel()
		super.init(coder: coder, rootView: DemoUnwindSecondView(vm: viewModel));
		viewModel.unwind = { [weak self] in
		   // call unwind segue created in storyboard
			self?.performSegue(withIdentifier: "unwind_segue_identifier", sender: self)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
