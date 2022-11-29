package back.kickoff.kickoffback.repositories;

import back.kickoff.kickoffback.model.CourtSchedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Component
@Repository
public interface ScheduleRepository extends JpaRepository<CourtSchedule, Long> {
}
