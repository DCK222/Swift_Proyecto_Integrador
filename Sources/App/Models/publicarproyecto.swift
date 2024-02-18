import Fluent
import Vapor

final class PublicarProyecto: Model, Content {
    static let schema = "publicar_proyecto"
    
   @ID(custom: "id_proy")
    var id: Int?
    
    @Field(key: "nombre_proy")
    var nombreProyecto: String?
    
    @Field(key: "localizacion")
    var localizacion: String?
    
    @Field(key: "nombre_creador")
    var nombreCreador: String?
    
    @Field(key: "disposicion")
    var disposicion: String?
    
    @Field(key: "num_inscritos")
    var numeroInscritos: Int?
    
    @Field(key: "estudios")
    var estudios: String?
    
    @Field(key: "curso_recomendado")
    var cursoRecomendado: String?
    
    @Field(key: "idiomas")
    var idiomas: String?
    
    @Field(key: "certificaciones")
    var certificaciones: String?
    
    @Field(key: "descripcion_proy")
    var descripcionProyecto: String?
    
    init() {}
    
    init(nombreProyecto: String, localizacion: String, nombreCreador: String, disposicion: String, numeroInscritos: Int, estudios: String, cursoRecomendado: String, idiomas: String, certificaciones: String, descripcionProyecto: String) {
        self.nombreProyecto = nombreProyecto
        self.localizacion = localizacion
        self.nombreCreador = nombreCreador
        self.disposicion = disposicion
        self.numeroInscritos = numeroInscritos
        self.estudios = estudios
        self.cursoRecomendado = cursoRecomendado
        self.idiomas = idiomas
        self.certificaciones = certificaciones
        self.descripcionProyecto = descripcionProyecto
    }
}