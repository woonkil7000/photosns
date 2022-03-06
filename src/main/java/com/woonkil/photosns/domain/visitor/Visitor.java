package com.woonkil.photosns.domain.visitor;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name="visitor")
public class Visitor {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String ip;
    private String pageUrl;
    private String device;
    private Integer userId;
    /*@JsonIgnoreProperties("visitor")
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="userId")
    private User user;*/

    @CreationTimestamp
    private LocalDateTime createDate;

    @PrePersist
    public void createDate() { this.createDate= LocalDateTime.now(); }

    @Override
    public String toString() {
        return "Visitor{" +
                "id=" + id +
                ", ip='" + ip + '\'' +
                ", pageUrl='" + pageUrl + '\'' +
                // ", user=" + user +
                ", createDate=" + createDate +
                '}';
    }
}
