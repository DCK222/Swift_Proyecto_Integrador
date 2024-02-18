import Vapor
import Fluent

struct ProyectoControlador: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let rutasProyectos = routes.grouped("proyectos")

        rutasProyectos.delete(":id", use: deleteProyecto)
        rutasProyectos.get(use: obtenerTodos)
        rutasProyectos.post(use: crear)
        rutasProyectos.put(":id", use: actualizarProyecto)
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
    func deleteProyecto(req: Request) async throws -> HTTPStatus {

    guard let proyectoID = req.parameters.get("id", as: Int.self) else {
        throw Abort(.badRequest, reason: "ID del proyecto no proporcionado")
    }    
    guard let proyecto = try await PublicarProyecto.find(proyectoID, on: req.db) else {
        throw Abort(.notFound, reason: "No existe el proyecto")
    }
    try await proyecto.delete(on: req.db)
    return .ok
}

func actualizarProyecto(req: Request) async throws -> PublicarProyecto {
    guard let proyectoID = req.parameters.get("id", as: Int.self) else {
        throw Abort(.badRequest, reason: "ID del proyecto no proporcionado")
    }

    guard let proyectoExistente = try await PublicarProyecto.find(proyectoID, on: req.db) else {
        throw Abort(.notFound, reason: "Proyecto no encontrado con el ID proporcionado")
    }

    let datosActualizados = try req.content.decode(PublicarProyecto.self)

    proyectoExistente.nombreProyecto = datosActualizados.nombreProyecto ?? proyectoExistente.nombreProyecto
    proyectoExistente.localizacion = datosActualizados.localizacion ?? proyectoExistente.localizacion
    proyectoExistente.nombreCreador = datosActualizados.nombreCreador ?? proyectoExistente.nombreCreador
    proyectoExistente.disposicion = datosActualizados.disposicion ?? proyectoExistente.disposicion
    proyectoExistente.numeroInscritos = datosActualizados.numeroInscritos ?? proyectoExistente.numeroInscritos
    proyectoExistente.estudios = datosActualizados.estudios ?? proyectoExistente.estudios
    proyectoExistente.cursoRecomendado = datosActualizados.cursoRecomendado ?? proyectoExistente.cursoRecomendado
    proyectoExistente.idiomas = datosActualizados.idiomas ?? proyectoExistente.idiomas
    proyectoExistente.certificaciones = datosActualizados.certificaciones ?? proyectoExistente.certificaciones
    proyectoExistente.descripcionProyecto = datosActualizados.descripcionProyecto ?? proyectoExistente.descripcionProyecto

    try await proyectoExistente.save(on: req.db)

    return proyectoExistente
}


    
}
