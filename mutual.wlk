

class Viaje{
    const idiomas = #{}

    method idiomas() = idiomas 

    method implicaEsfuerzo() = true

    method esInteresante()  = idiomas.size() > 1

    method sirveParaBroncearce() = true

    method cantDias()   
}

class ViajePlaya inherits Viaje{
    const largo

    override method cantDias() =  largo / 500

    override method implicaEsfuerzo() =  largo > 1200

}

class ExcursionCiudad inherits Viaje{
    const cantAtracciones

    override  method cantDias() = cantAtracciones / 2

    override method implicaEsfuerzo() = cantAtracciones.between(5, 8)

    override method sirveParaBroncearce() = false

    override method esInteresante() = super() || cantAtracciones == 5

}

class ExcursionCiudadTropical inherits ExcursionCiudad{
    override  method cantDias() = super() + 1

    override method sirveParaBroncearce() = true

}

class SalidaTrekking inherits Viaje{
    const kilometros
    const diasDeSol

    override  method cantDias() = kilometros / 50

    override method implicaEsfuerzo() = kilometros > 80

    override method sirveParaBroncearce() = diasDeSol > 200 || (diasDeSol.between(100, 200) && kilometros > 120)

    override method esInteresante() = super() && diasDeSol > 140

}

class ClaseGimnasia inherits Viaje{
    // const idiomas = #{}
    method initialize(){
        idiomas.clear()
        idiomas.add("español")
    }

    override method sirveParaBroncearce() = false

    override method cantDias() = 1   
}

class Socio{
    const actividades = []
    const cantMaxActivid
    var edad
    const idiomasQueHabla = #{}

    method initialize(){
        actividades.clear()
    }

    method esAdoradorDelSol() = actividades.all({act => act.sirveParaBroncearce()})

    method actividadesEsforzadas() = actividades.filter({act => act.implicaEsfuerzo()})

    method registrarActividad(unaActividad){
        if(actividades.size() == cantMaxActivid){
            self.error("El socio alcanzo el maximo de actividades")
        }
        actividades.add(unaActividad)
    }

    method leAtraeLaActividad(unaActividad) 

}

class SocioTranquilo inherits Socio{
    override method leAtraeLaActividad(unaActividad) = unaActividad.cantDias() >= 4
}

class SocioCoherente inherits Socio{
    override method leAtraeLaActividad(unaActividad) = if(self.esAdoradorDelSol()) unaActividad.sirveParaBroncearce() else unaActividad.implicaEsfuerzo()
}

class SocioRelajado inherits Socio{
    override method leAtraeLaActividad(unaActividad){
        return not idiomasQueHabla.intersection(unaActividad.idiomas()).isEmpty() 
    }
}