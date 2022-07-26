// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: This is a demo - use it as you wish. Reference is appriciated.
// If you want to thank - buy me coffee: https://secure.wayforpay.com/donate/asperi

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
