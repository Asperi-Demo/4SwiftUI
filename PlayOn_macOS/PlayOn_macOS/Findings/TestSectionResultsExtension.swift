// BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
// «Русский военный корабль, иди на хуй!» (c) Ukrainian Frontier Guard
//
// ATTENTION: 	By using this you agree do not repost any part of this code
//					on StackOverflow site. Thanks, Asperi.

import SwiftUI
import CoreData

struct TestSectionResultsExtension: View {
	var body: some View {
		TestView()
	}

	struct TestView: View {
		static var fetchRequest: NSFetchRequest<MedicationConsumption> {
			let result = MedicationConsumption.fetchRequest()
			result.sortDescriptors = [NSSortDescriptor(keyPath: \MedicationConsumption.date, ascending: true)]
			result.predicate = NSPredicate(format: "(medication.type == 1)")
			return result
		}
		@SectionedFetchRequest(fetchRequest: Self.fetchRequest, sectionIdentifier: \MedicationConsumption.group)
		private var consumption: SectionedFetchResults<String?, MedicationConsumption>

		// Use case scenario
		var body: some View {
			VStack {
				List(consumption) { section in
					VStack {
						Text("\(section.totalQuantity)")
					}
				}
				Text("Grand Total: \(consumption.totalQuantity)")
			}
		}
	}
}

	class MedicationConsumption: NSManagedObject {
	}

	extension MedicationConsumption {

		@nonobjc public class func fetchRequest() -> NSFetchRequest<MedicationConsumption> {
			return NSFetchRequest<MedicationConsumption>(entityName: "MedicationConsumption")
		}

		@NSManaged public var date: Date?
		@NSManaged public var group: String?
		@NSManaged public var quantity: Double
	}

struct TestSectionResultsExtension_Previews: PreviewProvider {
	static var previews: some View {
		TestSectionResultsExtension()
	}
}

extension SectionedFetchResults where Result == MedicationConsumption {
	var totalQuantity: Double {
		self.reduce(0) { sum, section in
			section.reduce(into: sum) { $0 += $1.quantity }
		}
	}
}

extension SectionedFetchResults.Section where Result == MedicationConsumption {
	var totalQuantity: Double {
		self.reduce(0) { $0 + $1.quantity }
	}
}
