package back.kickoff.kickoffback.model;

import jakarta.persistence.*;
import lombok.*;

import org.hibernate.Hibernate;

import java.sql.Time;
import java.util.Objects;

@ToString
@RequiredArgsConstructor
@Setter
@Getter
@Table
@Entity
public class Court {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long id;
    public String Court_Number;
        @ManyToOne
    private CourtOwner courtOwner;
    private CourtState state;

    private String discription;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "fk_court_schedule")
    public CourtSchedule courtSchedule;

    public Court(String name, CourtOwner courtOwner, CourtState state, String discription, Time startWorkingHours,
                 Time endWorkingHours, Time endMorning,Integer morningCost, Integer nightCost, Integer minBookingHours)
    {
      this.Court_Number=name;
      this.courtOwner = courtOwner;
      this.state = state;
      this.discription=discription;
      this.courtSchedule = new CourtSchedule( this.id, startWorkingHours, endWorkingHours, endMorning, morningCost, nightCost, minBookingHours) ;

      }




    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        Court court = (Court) o;
        return id != null && Objects.equals(id, court.id);
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();
    }
}
