package back.kickoff.kickoffback.cotrollers;

import back.kickoff.kickoffback.services.AnnouncementService;
import back.kickoff.kickoffback.services.CourtOwnerAgent;
import org.json.JSONException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@CrossOrigin
@RequestMapping("/courtOwnerAgent")
public class CourtOwnerAgentController {
    private final CourtOwnerAgent courtOwnerAgent;
    private final AnnouncementService announcementService;

    public CourtOwnerAgentController(CourtOwnerAgent courtOwnerAgent, AnnouncementService announcementService) {
        this.courtOwnerAgent = courtOwnerAgent;
        this.announcementService = announcementService;
    }


    @GetMapping("/CourtOwner/{courtOwnerId}/Courts")
    public ResponseEntity<String> listCourts(@PathVariable String courtOwnerId) throws JSONException {
        return new ResponseEntity<>(courtOwnerAgent.
                findCourtOwnerCourts(Long.valueOf(courtOwnerId)),
                HttpStatus.OK);
    }

    @PostMapping("/CourtOwner/CreateCourt")
    public ResponseEntity<String> createCourt(@RequestBody String information) throws JSONException {

        String response = courtOwnerAgent.createCourt(information);
        if (response.equals("Success"))
            return new ResponseEntity<>(response, HttpStatus.CREATED);
        return new ResponseEntity<>(response, HttpStatus.NOT_FOUND);
    }

    @PostMapping("/CourtOwner/addImage")
    public ResponseEntity<String> addImage(@RequestBody String information) throws JSONException {
        String responseBody = courtOwnerAgent.addImage(information);

        if (responseBody.equals("Success"))
            return new ResponseEntity<>(responseBody, HttpStatus.OK);
        return new ResponseEntity<>(responseBody, HttpStatus.BAD_REQUEST);
    }


    @PostMapping("/CourtOwner/CreateAnnouncement")
    public ResponseEntity<String> CreateAnnouncement(@RequestBody String information) throws JSONException {
        String responseBody = announcementService.addAnnouncement(information);

        if (responseBody.equals("Success"))
            return new ResponseEntity<>(responseBody, HttpStatus.OK);
        return new ResponseEntity<>(responseBody, HttpStatus.BAD_REQUEST);
    }


    @GetMapping("/CourtOwner/{courtOwnerId}/Announcements")
    public ResponseEntity<String> getAnnouncements(@PathVariable String courtOwnerId) {
        String responseBody = announcementService.getAnnouncement(Long.valueOf(courtOwnerId));
        if (responseBody.equals("CourtOwner do not exist"))
            return new ResponseEntity<>(responseBody, HttpStatus.NOT_FOUND);
        return new ResponseEntity<>(responseBody, HttpStatus.OK);
    }


    @PostMapping("/CourtOwner/{courtOwnerId}/deleteAnnouncement")
    public ResponseEntity<String> deleteAnnouncements(@PathVariable String courtOwnerId, @RequestBody String information) throws JSONException {
        String responseBody = announcementService.deleteAnnouncement(Long.valueOf(courtOwnerId), information);
        if (responseBody.equals("Success"))
            return new ResponseEntity<>(responseBody, HttpStatus.OK);
        return new ResponseEntity<>(responseBody, HttpStatus.BAD_REQUEST);

    }


}
