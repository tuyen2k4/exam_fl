package com.example.ExamFlutter.controllers;

import com.example.ExamFlutter.dtos.PlaceDTO;
import com.example.ExamFlutter.dtos.ResponseObject;
import com.example.ExamFlutter.services.PlaceService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/place")
public class PlaceController {
    private final PlaceService placeService;

    public PlaceController(PlaceService placeService) {
        this.placeService = placeService;
    }

    @GetMapping("")
    ResponseEntity<ResponseObject> getAll() {
        try {
            List<PlaceDTO> list = placeService.getAll();
            return ResponseEntity.status(HttpStatus.OK).body(
                    new ResponseObject(true, 200, "ok", list)
            );
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                    new ResponseObject(true, 400, "Bad Request", "")
            );
        }
    }
}
