//
//  AssemblyFactoryProtocol.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/27/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//

import Foundation

protocol AssemblyFactoryProtocol: class {
    
    var storyboardModule: StoryboardModuleProtocol { get }
    var rootModule: RootAssemblyProtocol { get }
    var welcomeModule: WelcomeAssemblyProtocol { get }
    var sliderModule: SliderAssemblyProtocol { get }
    var loginModule: LoginAssemblyProtocol { get }
    var registerModule: RegistrationAssembly { get }
    var confirmModule: ConfirmAssembly { get }
    var dashboardModule: DashboardAssembly { get }
    var myInsurancesModule: MyInsranceAssembly { get }
    var mainModule: MainAssembly { get }
    var osagoModule: OsagoAssembly { get }
    var pledgedTransportModule: MandatoryAssembly { get }
    var homeModule: HomeAssembly { get }
    var kaskoModule: KaskoAssembly { get }
    var pledgedPropertyModule: IpotekaAssembly { get }
    var accidentModule: AccidentAssembly { get }
    var healthModule: HealthAssembly { get }
    var sportModule: SportAssembly { get }
    var roadTechModule: RoadTechAssembly { get }
    var gasHomeModule: GasAssembly { get }
    var gasAutoModule: GasEquipmentAssembly { get }
    var infectionModule: InfectionAssembly { get }
    var mobilePhoneModule: MobilePhoneAssembly { get }
    var incidentModule: IncidentsAssembly { get }
    var myInsuranceDetailModule: MyInsurnacesDetailAssembly { get }
    var addInsuranceModule: AddInsuranceAssembly { get }
    var incidentsDetailModule: IncidentsDetailAssembly { get }
    var mainProfileModule: MainProfileAssembly { get }
    var officesModule: OfficesAssembly { get }
    var incidentsAddEditModule: IncidentsAddEditAssembly { get }
    var incidentInfoModuule: IncidentInfoAssembly { get }
    var orderCheckModule: OrderCheckAssembly { get }
    var luggageModule: LuggageAssembly { get }
    var myDocumentsModule: MyDocumentsAssembly { get }
    var travelModule: TravelAssembly { get }
    var settingsModule: SettingsAssembly { get }
    var insuranceListModule: InsuranceListAssembly { get }
    var notificationModule: NotificationAssembly { get }
    var chatModule: ChatAssembly { get }
    var faqModule: FaqAssembly { get }
    var offerModule: OfferAssembly { get }
    
}

class AssemblyFactory: AssemblyFactoryProtocol {
    
    lazy var storyboardModule: StoryboardModuleProtocol = {
        let module = StoryboardModule()
        return module
    }()
    
    lazy var rootModule: RootAssemblyProtocol = {
        let module = RootAssembly(
            serviceFactory: self.serviceFactory,
            storyboard: self.storyboardModule.main,
            assemblyFactory: self)
        return module
    }()
    
    lazy var welcomeModule: WelcomeAssemblyProtocol = {
        let module = WelcomeAssembly(
            serviceFactory: self.serviceFactory,
            storyboard: self.storyboardModule.main,
            assemblyFactory: self)
        return module
    }()
    
    lazy var sliderModule: SliderAssemblyProtocol = {
        let module = SliderAssembly(
            serviceFactory: self.serviceFactory,
            storyboard: self.storyboardModule.main,
            assemblyFactory: self)
        return module
    }()
    
    lazy var loginModule: LoginAssemblyProtocol = {
        let module = LoginAssembly(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var registerModule: RegistrationAssembly = {
        let module = RegistrationAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var confirmModule: ConfirmAssembly = {
        let module = ConfirmAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var dashboardModule: DashboardAssembly = {
        let module = DashboardAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var mainModule: MainAssembly = {
        let module = MainAssembly(serviceFactory: self.serviceFactory, assemblyFactory: self)
        return module
    }()
    
    lazy var osagoModule: OsagoAssembly = {
        let module = OsagoAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    
    lazy var pledgedPropertyModule: IpotekaAssembly = {
        let module = IpotekaAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var pledgedTransportModule: MandatoryAssembly = {
        let module = MandatoryAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var homeModule: HomeAssembly = {
        let module = HomeAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var kaskoModule: KaskoAssembly = {
        let module = KaskoAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    
    lazy var accidentModule: AccidentAssembly = {
        let module = AccidentAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var healthModule: HealthAssembly = {
        let module = HealthAssembleImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var sportModule: SportAssembly = {
        let module = SportAssemblyImpl(serviceFactory: self.serviceFactory, assemblyFactory: self)
        
        return module
    }()
    
    lazy var roadTechModule: RoadTechAssembly = {
        let module = RoadTechAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var gasHomeModule: GasAssembly = {
        let module = GasAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var infectionModule: InfectionAssembly = {
        let module = InfectionAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var mobilePhoneModule: MobilePhoneAssembly = {
        let module = MobilePhoneAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var gasAutoModule: GasEquipmentAssembly = {
        let module = GasEquipmentAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var myInsurancesModule: MyInsranceAssembly = {
        let module = MyInsuranceAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var incidentModule: IncidentsAssembly = {
        let module = IncidentsAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var myInsuranceDetailModule: MyInsurnacesDetailAssembly = {
        let module = MyInsurnacesDetailAssembly(serviceFactory: self.serviceFactory, assemblyFactory: self)
        return module
    }()
    
    lazy var addInsuranceModule: AddInsuranceAssembly = {
        let module = AddInsuranceAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var incidentsDetailModule: IncidentsDetailAssembly = {
        let module = IncidentsDetailAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var mainProfileModule: MainProfileAssembly = {
        let module = MainProfileAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var officesModule: OfficesAssembly = {
        let module = OfficesAssemblyImpl(serviceFactory: self.serviceFactory, assemblyFactory: self)
        return module
    }()
    
    lazy var incidentsAddEditModule: IncidentsAddEditAssembly = {
        let module = IncidentsAddEditAssemblyImpl(serviceFactory: self.serviceFactory, assemblyFactory: self)
        return module
    }()
    
    lazy var incidentInfoModuule: IncidentInfoAssembly = {
        let module = IncidentInfoAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var orderCheckModule: OrderCheckAssembly = {
        let module = OrderCheckAssemblyImpl(serviceFactory: self.serviceFactory, assemblyFactory: self)
        return module
    }()
    
    lazy var luggageModule: LuggageAssembly = {
        let module = LuggageAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var myDocumentsModule: MyDocumentsAssembly = {
        let module = MyDocumentsAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var travelModule: TravelAssembly = {
        let module = TravelAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var settingsModule: SettingsAssembly = {
        let module = SettingsAssemblyImpl(serviceFactory: self.serviceFactory, assemblyFactory: self)
        return module
    }()
    
    lazy var insuranceListModule: InsuranceListAssembly = {
        let module = InsuranceListAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var notificationModule: NotificationAssembly = {
        let module = NotificationAssemblyImpl(serviceFactory: self.serviceFactory, assemblyFactory: self)
        return module
    }()
    
    lazy var chatModule: ChatAssembly = {
        let module = ChatAssemblyImpl(serviceFactory: self.serviceFactory, assemblyFactory: self)
        return module
    }()
    
    lazy var faqModule: FaqAssembly = {
        let module = FaqAssemblyImpl(serviceFactory: self.serviceFactory, mainStoryboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    lazy var offerModule: OfferAssembly = {
        let module = OfferAssemblyImpl(serviceFactory: self.serviceFactory, storyboard: self.storyboardModule.main, assemblyFactory: self)
        return module
    }()
    
    private var serviceFactory: ServiceFactoryProtocol
    
    init(serviceFactory: ServiceFactoryProtocol) {
        self.serviceFactory = serviceFactory;
    }
    
}
