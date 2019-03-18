# MovieAppEvana

## Capas de la aplicación
### MVVM
La aplicación fue desarrollada con el model MVVM(Model View View Model) y consta de las siguientes capas:
- Modelo: consta de todos los objetos relativos a el API de Movie DB, todos los objetos presentes en esta capa fueron creados de acuerdo a NSManagedObject y Codable/Decodable con el fin de poder persistirse en CoreData y a su vez parsearse directamente mediante Alamorife.
- Servicios: Esta es una capa que se puede considerar parte del modelo también, esta capa como se mencionó en el punto anterior es manejada por Alamofire, consiste en dos capas auxiliares: Reach y APIManager, así como capas comunes para cada sección de la aplicación. Cada uno de los servicios correspondientes a los módulos de la aplicación cuenta también con un protocolo.
- View Model: Esta capa hace todo el procesamiento de los datos recibidos mediante la API, con el fin de enviarlos a la vista ya procesados y que la vista se encargue únicamente de desplegarlos.
- Vista: Esta capa se compone del ViewController y de la vista en sí, que son archivos .xib, la elección de XIB se debe al modelo de arquitectura utilizado (MVVM), sin embargo, también se podría llegar a acoplar con Storyboards de ser necesario.
- Persistencia: Esta capa se encarga de persistir los datos en Core Data y en caso de que el dispositivo se muestre sin conexión desplegará los últimos datos guardados en la memoria.

## Responsabilidad de las clases creadas
1. Common
   - MovieAppConstants:
2. Modelos
   - SearchResult
   - Movie
   - Collection
   - CollectionParts
   - Genre
   - ProductionCompany
   - ProductionCountries
   - SpokenLanguages
   - Configuration
   - Images
3. API
   - APIManager
   - Reach
4. Modules
   - Common
     - CustomCell
       - View
         - CategoriesCustomCell
       - ViewModel
         - CategoriesCustomCellViewModel
   - Categories
     - Protocol
       - CategoriesListServiceProtocol
     - Service
       - CategoriesListService
     - View
       - CategoriesTabBarViewController
       - Popular
         - PopularListViewController
       - Upcoming
         - UpcomingListViewController
       - TopRated
         - TopRatedListViewController
     - ViewModel
       - CategoriesListViewModel
   - CategoriesDetail
     - View
       - PopularDetailViewController
5. AppDelegate
