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
   - MovieAppConstants: Esta clase contiene todas las constantes presentes en la aplicación.
2. Modelos
   - SearchResult: Esta clase mapea el objeto de los resultados de búsqueda provenientes de la API.
   - Movie: Esta clase mapea el objeto de las películas provenientes de la API.
   - Collection: Esta clase mapea el objeto de las colecciones provenientes de la API.
   - CollectionParts: Esta clase mapea el objeto de las partes de las colecciones provenientes de la API.
   - Genre: Esta clase mapea el objeto de los géneros de las películas provenientes de la API.
   - ProductionCompany: Esta clase mapea el objeto de las compañías productoras provenientes de la API.
   - ProductionCountries: Esta clase mapea el objeto de los países productores provenientes de la API.
   - SpokenLanguages: Esta clase mapea el objeto de los idiomas hablados de las películas provenientes de la API.
   - Configuration: Esta clase mapea el objeto de la configuración proveniente de la API.
   - Images: Esta clase mapea el objeto de las imágenes provenientes de la API.
3. API
   - APIManager: Esta clase es un helper para las conexiones con la API a través de Alamofire.
   - Reach: Esta clase es un helper para monitorear si el dispositivo tiene o no conexión a internet.
4. Modules
   - Common
     - CustomCell
       - View
         - CategoriesCustomCell: Esta clase es la vista de las celdas de la lista que muestra las películas.
       - ViewModel
         - CategoriesCustomCellViewModel: Esta clase es el modelo de la vista de las celdas de la lista que muestra las películas.
   - Categories
     - Protocol
       - CategoriesListServiceProtocol: Este es el protocolo que define los métodos de los servicios que se llaman en la aplicación.
     - Service
       - CategoriesListService: Esta clase contiene la lógica y llamados a los servicios a la API.
     - View
       - CategoriesTabBarViewController: Esta clase controla la vista de TabBar en la parte inferior de la aplicación.
       - Popular
         - PopularListViewController: Esta clase controla la lista de películas populares.
       - Upcoming
         - UpcomingListViewController: Esta clase controla la lista de películas upcoming.
       - TopRated
         - TopRatedListViewController: Esta clase controla la lista de películas top rated.
     - ViewModel
       - CategoriesListViewModel: Esta clase genera el modelo de la vista para las tres listas de la aplicación (popular, upcoming y top rated).
   - CategoriesDetail
     - View
       - PopularDetailViewController: Esta clase controla la vista del detalle de las películas de la aplicación.
5. AppDelegate: Esta es una clase común a todas las aplicaciones de iOS que se hace cargo del ciclo de vida de la aplicación.

## ¿En qué consiste el principio de responsabilidad única? ¿Cuál es su propósito?
Consiste en que cada una de las clases, modulos o funciones de la aplicación debe hacerse responsable únicamente de una parte de la funcionalidad de la aplicación. El propósito es que cuando se edite o modifique una de las partes de la aplicación sólo sea por un motivo específico y que no se pueda afectar a otras partes de la aplicación, así mismo, le da una mayor mantenibilidad al código.

## ¿Qué características tiene, según su opinión, un “buen” código o código limpio?
Es un código de fácil mantenibilidad, donde se puede entender cada uno de los propósitos de cada método y clase con sólo mirarlos. En este tipo de código las variables y métodos tienen nombres descriptivos que nos permiten entender. Es código donde se evitan las funciones repetitivas y se evita el llamado código espaguetti. Es también un código en el que se hacen refactors periódicos con el fin de mantenerlo, pues también con el paso del tiempo se puede afectar la limpieza del código. También es código que tiene comentarios y documentación que permiten clarificar las intenciones de cada una de las partes. Se basa en los principios de ingeniería de software y como tal tiene claro uso de estructuras de datos y otras técnicas dependiendo del lenguaje u objetivo del mismo.

