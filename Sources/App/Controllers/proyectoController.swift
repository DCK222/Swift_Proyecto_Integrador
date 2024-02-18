import Vapor
import Fluent

struct ProyectoControlador: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let rutasProyectos = routes.grouped("proyectos")

        rutasProyectos.get(use: obtenerTodos)
        rutasProyectos.post(use: crear)
    }
    
    // Manejador para obtener todos los proyectos
    func obtenerTodos(_ req: Request) -> EventLoopFuture<[PublicarProyecto]> {
        return PublicarProyecto.query(on: req.db).all()
    }
    
    // Manejador para crear un nuevo proyecto
    func crear(_ req: Request) throws -> EventLoopFuture<PublicarProyecto> {
    let proyecto = try req.content.decode(PublicarProyecto.self)
    return proyecto.save(on: req.db).map { proyecto }
}
}
