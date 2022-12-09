package back.kickoff.kickoffback.services;

import back.kickoff.kickoffback.model.CourtSchedule;
import back.kickoff.kickoffback.model.Reservation;
import back.kickoff.kickoffback.repositories.PlayerRepositry;
import back.kickoff.kickoffback.repositories.ReservationRepository;
import back.kickoff.kickoffback.repositories.ScheduleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class ScheduleAgent {

    @Autowired
    ScheduleRepository sr ;

    @Autowired
    ReservationRepository rr ;

    public ScheduleAgent(ScheduleRepository sr, ReservationRepository rr) {
        this.rr = rr;
        this.sr = sr;
    }


    public List<Reservation> getScheduleOverlapped(Date fromD, Date toD, Time fromT, Time toT, CourtSchedule schedule){
        ArrayList<Reservation> res = new ArrayList<Reservation>() ;
        for(Reservation r: schedule.getBookedReservations()){
            if(!r.getStartDate().equals(fromD))
                continue;
            if(((r.getTimeFrom().after(fromT) || r.getTimeFrom().equals(fromT)) &&
                    (r.getTimeTo().before(toT) || r.getTimeTo().equals(toT)) )
                    || (r.getTimeFrom().before(fromT) && r.getTimeTo().after(fromT))
                    || (r.getTimeFrom().before(toT) && r.getTimeTo().after(toT))){
                res.add(r) ;
            }

        }
        for(Reservation r: schedule.getPendingReservations()){
            if(!r.getStartDate().equals(fromD))
                continue;
            if(((r.getTimeFrom().after(fromT) || r.getTimeFrom().equals(fromT)) &&
                    (r.getTimeTo().before(toT) || r.getTimeTo().equals(toT)) )
                    || (r.getTimeFrom().before(fromT) && r.getTimeTo().after(fromT))
                    || (r.getTimeFrom().before(toT) && r.getTimeTo().after(toT))){
                res.add(r) ;
            }
        }

        return res ;

    }


}
